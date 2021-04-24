import cv2
import numpy as np
from numpy.linalg import svd
import matplotlib.pyplot as plt
import scipy
from scipy.linalg import norm
from scipy.signal import medfilt

from sklearn.linear_model import LinearRegression
from sklearn.linear_model import RANSACRegressor

### Time between frames ####
tbt = 1/30 #sec

#######Camera matrix (not needed)
 # [[3.91443821e+03 0.00000000e+00 5.18165259e+02]
 # [0.00000000e+00 5.29202205e+03 9.01575822e+02]
 # [0.00000000e+00 0.00000000e+00 1.00000000e+00]]
 # And is stored in calibration.yaml file along with distortion coefficients :
 # [[-8.17449595e-01  1.48825370e+01  4.09990407e-02 -4.94417486e-02
 #  -8.72754321e+01]]

def nearest_intersection(points, dirs):
    """
    :param points: (N, 3) array of points on the lines
    :param dirs: (N, 3) array of unit direction vectors
    :returns: (3,) array of intersection point
    """
    dirs_mat = dirs[:, :, np.newaxis] @ dirs[:, np.newaxis, :]
    points_mat = points[:, :, np.newaxis]
    I = np.eye(2)
    return np.linalg.lstsq(
        (I - dirs_mat).sum(axis=0),
        ((I - dirs_mat) @ points_mat).sum(axis=0),
        rcond=None
    )[0]

def intersect(P0,P1):
    P1 = np.array(P1)
    P0 = np.array(P0)
    P1 = P1.astype(np.float64)
    P0 = P0.astype(np.float64)
    n = (P1-P0)/np.linalg.norm(P1-P0,axis=1)[:,np.newaxis] # normalized

    # n = np.ma.array(n, mask=np.isnan(n))
    projs = np.eye(n.shape[1]) - n[:,:,np.newaxis]*n[:,np.newaxis]  # I - n*n.T
    # see fig. 1
    # print(n)
    # P0 = np.array(P0)
    # generate R matrix and q vector
    R = projs.sum(axis=0)
    q = (projs @ P0[:,:,np.newaxis]).sum(axis=0)

    # solve the least squares problem for the
    # intersection point p: Rp = q
    p = np.linalg.lstsq(R,q,rcond=-1)[0]

    return p

def cal_average(num):
    """
    Find average of array
    """
    return sum(num)/len(num)
    

# Choose video 
# cap = cv2.VideoCapture('/Users/arthurlago/Documents/UAV/fg.mp4')
# cap = cv2.VideoCapture('/Users/arthurlago/Documents/UAV/Videos/O meu filme.mp4')
cap = cv2.VideoCapture('filme-teste-2.mp4')
# cap = cv2.VideoCapture('lk3-9.mp4')

width  = int(cap.get(3))
height = int(cap.get(4))

# Image center
w = int(width/2)
h = int(height/2)

# params for ShiTomasi corner detection
feature_params = dict( maxCorners = 675,
                       qualityLevel = 0.05,
                       minDistance = 2,
                       blockSize = 2 )

# Parameters for lucas kanade optical flow
lk_params = dict( winSize  = (15,15),
                  maxLevel = 2,
                  criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.01))

# Create some random colors
color = np.random.randint(0,255,(300,3))

# Take first frame
ret, old_frame = cap.read()
old_gray = cv2.cvtColor(old_frame, cv2.COLOR_BGR2GRAY)


####Mas assim estas a escolher "boas features"? Discutir usar o goodFeaturesToTrack (estava originalmente)

### For the first optical flow features use a patch on the lower center of the frame
dw1 = width/4
dh1 = height/4
dw = dw1/30
dh = dh1/10

p0 = []

idw=dw1
while idw<(3*dw1):
    idh=height/2
    while idh<(3*dh1):
        u = np.float32(([[idw, idh]]))
        p0.append(u)
        idh = idh+dh
    idw = idw+dw

p0 = np.array(p0)

# Create a mask image for drawing purposes
mask = np.zeros_like(old_frame)

#Video Writer
out = cv2.VideoWriter('outpy2.avi',cv2.VideoWriter_fourcc('M','J','P','G'), 10, (width, height))


ttc_x_overtime = []
ttc_y_overtime = []

counter_frame = 0

while(1):

    # Read current frame
    ret,frame = cap.read()
    if frame is None:
        break

    #Convert to greyscale
    frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # calculate optical flow
    p1, st, err = cv2.calcOpticalFlowPyrLK(old_gray, frame_gray, p0, None, **lk_params)

    #Frame number
    print("Frame {}".format(counter_frame+1))

    #If no features are found move to next
    if(p1 is None):
        continue

    ## Construct matrix A and vector b for focus of expansion calculation
    
    A_foe = np.zeros((len(p1),2), dtype=float)
    b_foe = np.zeros((len(p1),1), dtype=float)

    for j in range(len(p1)):

        x_linha = p1[j][0][0]
        y_linha = p1[j][0][1] 

        x_linha_prev = p0[j][0][0]
        y_linha_prev = p0[j][0][1]

        u = x_linha - x_linha_prev
        v = y_linha - y_linha_prev

        if(st[j] == 0 or any(np.isnan([x_linha, x_linha_prev, y_linha, y_linha_prev, u, v]))):
            continue

        A_foe[j][0] = v
        A_foe[j][1] = -u
        b_foe[j][0] = x_linha*v - y_linha*u

        if(np.isnan(A_foe[j][0]) or np.isnan(A_foe[j][1]) or np.isnan(b_foe[j][0])):
            A_foe[j][0] = 0
            A_foe[j][1] = 0
            b_foe[j][0] = 0


    ## Use RANSAC to ignore outliers - If it fails use simple least squares, if even that fails, use the center of the frame    
    try:
        regressor = LinearRegression(fit_intercept=False)
        ransacRegressor = RANSACRegressor(base_estimator=regressor, max_trials=10000).fit(A_foe, b_foe)
        x_foe = int(ransacRegressor.estimator_.coef_[0][0])
        y_foe = int(ransacRegressor.estimator_.coef_[0][1])
    except ValueError:
        try:
            lenp1 = len(p1)
            lenp0 = len(p0)
            lenp1x = p1[0:lenp1, 0, 0]
            lenp1y = p1[0:lenp1, 0, 1]
            lenp0x = p0[0:lenp0, 0, 0]
            lenp0y = p0[0:lenp0, 0, 1]
            pontos1 = np.vstack((lenp1x, lenp1y)).T
            pontos0 = np.vstack((lenp0x, lenp0y)).T
            n = (pontos1-pontos0)/np.linalg.norm(pontos1-pontos0,axis=1)[:,np.newaxis]
            n[np.isnan(n)] = 0
            ponto = nearest_intersection(pontos1, n)
            x_foe = int(ponto[0])
            y_foe = int(ponto[1])
        except:
            x_foe = w
            y_foe = h


    # Times to collsion
    all_ttc_x = []
    all_ttc_y = []

    ## Use optical flow vector to determine times to collision
    for i in range(len(p1)):

        u = ((p1[i][0][0]-p0[i][0][0]))/(tbt)
        v = ((p1[i][0][1]-p0[i][0][1]))/(tbt)

        if(abs(p1[i][0][0]-x_foe) < 0.00001 or abs(p1[i][0][1]-y_foe) < 0.00001):
            continue

        # Inverse time to colision
        i_ttc_x = (u)/(p1[i][0][0]-x_foe)
        i_ttc_y = (v)/(p1[i][0][1]-y_foe)

        if(i_ttc_x < 0.01 or i_ttc_y < 0.01):
            continue 

        # Time to collsion
        ttc_x = 1/i_ttc_x
        ttc_y = 1/i_ttc_y

        all_ttc_x.append(ttc_x)
        all_ttc_y.append(ttc_x)
        

    ## Determine final times to collision using median
    if len(all_ttc_x) > 0 and len(all_ttc_y) > 0:

        ttc_x = float(np.median(np.array(all_ttc_x)))
        ttc_y = float(np.median(np.array(all_ttc_y)))

        ttc_x_overtime.append(ttc_x)
        ttc_y_overtime.append(ttc_y)


    # Select good points
    good_new = p1[st==1]
    good_old = p0[st==1]

    ## draw the tracks
    for i,(new,old) in enumerate(zip(good_new,good_old)):
 
        cv2.arrowedLine(frame,(int(good_old[i][0]), int(good_old[i][1])),(int(1.0*(good_new[i][0]-width/2)+width/2), int(1.0*(good_new[i][1]-height/2)+height/2)),
                        color=(0, 255, 0),
                        thickness=2,
                        tipLength=.1)
                    
    frame = cv2.circle(frame,(x_foe,y_foe),10,(255, 255, 255),-1)
    img = cv2.add(frame,mask)

    cv2.namedWindow("frame", cv2.WINDOW_NORMAL)
    # out.write(img)
    cv2.imshow('frame',img)
    counter_frame += 1

    if cv2.waitKey(1) & 0xFF == ord('q'):
        cap.release()
        out.release()
        cv2.destroyAllWindows()
        break

    # Now update the previous frame and previous points ??? Nao deviamos fazer isto?
    old_gray = frame_gray.copy()
    # p0 = good_new.reshape(-1,1,2)
    # if (cnt%5)==0:
        # p0 = cv2.goodFeaturesToTrack(old_gray, mask = None, **feature_params)


#Apply median filter

ttc_x_overtime = list(medfilt(np.array(ttc_x_overtime), kernel_size=11)) 
ttc_y_overtime = list(medfilt(np.array(ttc_y_overtime), kernel_size=11))



## Apply moving average
window_size = 30

moving_averages_x = []
moving_averages_y = []

for i in range(len(ttc_x_overtime) -  window_size + 1):
    this_window = ttc_x_overtime[i:i + window_size]
    window_average = cal_average(this_window)
    moving_averages_x.append(window_average)

for i in range(len(ttc_y_overtime) -  window_size + 1):
    this_window = ttc_y_overtime[i:i + window_size]
    window_average = cal_average(this_window)
    moving_averages_y.append(window_average)


print('\n\n\n\n\n')
print('Total frames: {}'.format(counter_frame))
print('\n\n\n\n\n')


## Create final plot
moving_averages_total = [(x + y)/2 for x, y in zip(moving_averages_x, moving_averages_y)]
plt.plot(moving_averages_x, color="darkblue")
plt.plot(moving_averages_y, color="darkgreen")
plt.plot(moving_averages_total, color="darkorange", linewidth=3)
plt.savefig('dataz-lk3-1.png')
