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

#######Camera matrix
##Camera matrix is
 # [[3.91443821e+03 0.00000000e+00 5.18165259e+02]
 # [0.00000000e+00 5.29202205e+03 9.01575822e+02]
 # [0.00000000e+00 0.00000000e+00 1.00000000e+00]]
 # And is stored in calibration.yaml file along with distortion coefficients :
 # [[-8.17449595e-01  1.48825370e+01  4.09990407e-02 -4.94417486e-02
 #  -8.72754321e+01]]

fx = 3914.4382149986263
fy = 5292.022047704224
d1 = -8.17449595e-01
# d2 =
#### Constant velocity in Z ####
# Tz = 0.2 #ms^-1
#
# Ty = 0
# Tx = 0
#
# wx = 0
# wy = 0
# wz = 0
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
    # print('passou')

    return p

def cal_average(num):
    sum_num = 0
    for t in num:
        sum_num = sum_num + t

    avg = sum_num / len(num)
    return avg

dataz00 = []
dataz10 = []
dataz0 = []
dataz1 = []

# cap = cv2.VideoCapture('/Users/arthurlago/Documents/UAV/fg.mp4')
# cap = cv2.VideoCapture('/Users/arthurlago/Documents/UAV/Videos/O meu filme.mp4')
cap = cv2.VideoCapture('filme-teste-2.mp4')
# cap = cv2.VideoCapture('lk3-9.mp4')
width  = cap.get(3) # float
height = cap.get(4)

print(width, height)
w = width/2
h = height/2

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

# Take first frame and find corners in it
ret, old_frame = cap.read()
old_gray = cv2.cvtColor(old_frame, cv2.COLOR_BGR2GRAY)
# p0 = cv2.goodFeaturesToTrack(old_gray, mask = None, **feature_params)
p0 = []
# print(p0)
dw1 = width/4
dh1 = height/4
dw = dw1/30
dh = dh1/10

idw=dw1

while idw<(3*dw1):
    idh=height/2
    while idh<(3*dh1):
        # idw = float(idw)
        # idh = float(idh)
        u = np.float32(([[idw, idh]]))
        p0.append(u)
        idh = idh+dh
    idw = idw+dw
p0 = np.array(p0)
print(p0)
# print(p0)
# Create a mask image for drawing purposes
mask = np.zeros_like(old_frame)

frame_width = int(cap.get(3))
frame_height = int(cap.get(4))
out = cv2.VideoWriter('outpy2.avi',cv2.VideoWriter_fourcc('M','J','P','G'), 10, (frame_width,frame_height))
frameDistances1=[]
frameDistances2=[]
counter_frame = 0
cnt=0
Tx_antigo = 0
Ty_antigo = 0
Tz_antigo = 0
while(1):
    ret,frame = cap.read()
    if frame is None:
        break
    frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # calculate optical flow
    p1, st, err = cv2.calcOpticalFlowPyrLK(old_gray, frame_gray, p0, None, **lk_params)

    # print(st)
    # print(len(p0))
    # print(len(p1))
    print("Frame {}".format(cnt))

    if(p1 is None):
        # print (cnt)
        continue
    #i=0
    #lenp1  = len(p1)
    #lenp0 = len(p0)

    #lenp1x = p1[0:lenp1, 0, 0]
    #lenp1y = p1[0:lenp1, 0, 1]
    #lenp0x = p0[0:lenp0, 0, 0]
    #lenp0y = p0[0:lenp0, 0, 1]
    #pontos1 = np.vstack((lenp1x, lenp1y)).T
    #pontos0 = np.vstack((lenp0x, lenp0y)).T
    # pontos1 = np.array(pontos1)
    # pontos0 = np.array(pontos0)
    # pontos1 = np.absolute(pontos1)
    # pontos1 = np.float32(pontos1)

    # print(len(pontos1))
    # print('\n\n\n\n\n')
    # print(len(pontos0))
    #n = (pontos1-pontos0)/np.linalg.norm(pontos1-pontos0,axis=1)[:,np.newaxis]
    #where_are_NaNs = np.isnan(n)
    #n[where_are_NaNs] = 0
    # print(n)
    # n= n[:,np.newaxis]
    # print(n)
    #ponto = nearest_intersection(pontos1, n)
    # ponto = intersect(pontos1, pontos0)
    # print(passou)
    # ponto = [(w), (h)]
    # print(ponto[0][0])
    # Tx = 0.005
    Tx = 0.09823529
    Ty = 0
    # Tz = 0.11764706
    Tz = 0.027
    Wx = 0
    Wy = 0
    Wz = 0
    dataz00=[]
    dataz01=[]
    disp0 = []
    disp1 = []

    #if(len(p1) < 50):
    #    continue

    
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

    x_foe = w
    y_foe = h
    
    try:
        regressor = LinearRegression(fit_intercept=False)
        ransacRegressor = RANSACRegressor(base_estimator=regressor, max_trials=10000).fit(A_foe, b_foe)
        x_foe = int(ransacRegressor.estimator_.coef_[0][0])
        y_foe = int(ransacRegressor.estimator_.coef_[0][1])
        #print(ransacRegressor.estimator_.coef_)
    except ValueError:
        #print(A_foe)
        print("Value Error")

    for i in range(len(p1)):
        u = ((p1[i][0][0]-p0[i][0][0]))/(tbt)
        
        #Porque é que é menos?
        v = ((p1[i][0][1]-p0[i][0][1]))/(tbt)
        p = np.array([[u], [v]])

        # print(p)



        A = np.array([[-1, 0, (w-p1[i][0][0])], [0, -1, (h-p1[i][0][1])]]) ###DIFERENTE DO lk4
        B = np.array([[Tx], [Ty], [Tz]])
        C = A.dot(B)

        ###ROTAÇÃO######
        Rot = np.array([ [(p1[i][0][0]*p1[i][0][1]), -(1+(p1[i][0][0])*(p1[i][0][0])), (p1[i][0][1])], [(1+(p1[i][0][1])*(p1[i][0][1])), -(p1[i][0][0]*p1[i][0][1]), -p1[i][0][0]] ])
        Ang = np.array([[Wx], [Wy], [Wz]])
        R = Rot.dot(Ang)
        # print(R)
        # print('\n')

        # C1 = np.subtract(p, np.matmul(Rot, Ang))
        # C2 = np.matmul(A, B)
        # dispx1 = p1[i][0][0]
        # dispy1 = p1[i][0][1]
        # dispx0 = p0[i][0][0]
        # dispy0 = p0[i][0][1]
        # disp1.append((dispx1, dispy1))
        # disp0.append((dispx0, dispy0))

        if(abs(p1[i][0][0]-x_foe) < 0.00001 or abs(p1[i][0][1]-y_foe) < 0.00001):
            continue

        ttcx = (u)/(p1[i][0][0]-x_foe)
        ttcy = (v)/(p1[i][0][1]-y_foe)

    
        #if(cnt == 150):
        #    print(u, p1[i][0][1], y_foe)
            #print(ttcy)

        if(ttcx < 0.01 or ttcy < 0.01):
            continue 

        ttcx = 1/ttcx
        ttcy = 1/ttcy

        dataz00.append(ttcx)
        dataz01.append(ttcy)
        



    disp1 = np.array(disp1)
    disp0 = np.array(disp0)
    # print(disp1)
    # if z1>-2 and z1<2:
    if len(dataz00)>0:
        #x1 = cal_average(dataz00)
        #x2 = cal_average(dataz01)

        x1 = float(np.median(np.array(dataz00)))
        x2 = float(np.median(np.array(dataz01)))

        frameDistances1.append(x1)
        frameDistances2.append(x2)

        # dispx2 = cal_average(dispx)
        # dispy2 = cal_average(dispy)
    #print(p1)
    # frameDistances.append(z)
    # dataz1.append(y1)

    # Select good points
    good_new = p1[st==1]
    good_old = p0[st==1]
    # draw the tracks
    i=0
    for i,(new,old) in enumerate(zip(good_new,good_old)):
        # a,b = new.ravel()
        # c,d = old.ravel()
        cv2.arrowedLine(frame,(int(good_old[i][0]), int(good_old[i][1])),(int(1.0*(good_new[i][0]-frame_width/2)+frame_width/2), int(1.0*(good_new[i][1]-frame_height/2)+frame_height/2)),
                        color=(0, 255, 0),
                        thickness=2,
                        tipLength=.1)
        # mask = cv2.line(mask, (a,b),(c,d), color[i].tolist(), 2)
    #frame = cv2.circle(frame,(int(ponto[0]),int(ponto[1])),10,(0, 0, 255),-1)
    frame = cv2.circle(frame,(x_foe,y_foe),10,(255, 255, 255),-1)
    img = cv2.add(frame,mask)

    cv2.namedWindow("frame", cv2.WINDOW_NORMAL)
    # out.write(img)
    cv2.imshow('frame',img)
    counter_frame = counter_frame+1
    Tx_antigo = Tx
    Ty_antigo = Ty
    Tz_antigo = Tz
    cnt=cnt+1
    if cv2.waitKey(1) & 0xFF == ord('q'):
        cap.release()
        out.release()
        cv2.destroyAllWindows()
        break

    # Now update the previous frame and previous points
    old_gray = frame_gray.copy()
    # p0 = good_new.reshape(-1,1,2)
    # if (cnt%5)==0:
        # p0 = cv2.goodFeaturesToTrack(old_gray, mask = None, **feature_params)
    #if cv2.waitKey(0) & 0xFF == ord('w'):
    #    continue

if dataz1 is not None:

    frameDistances1 = list(medfilt(np.array(frameDistances1), kernel_size=11)) 
    frameDistances2 = list(medfilt(np.array(frameDistances2), kernel_size=11))

    window_size = 30

    i = 0
    moving_averages = []
    while i < len(frameDistances2) -  window_size +1:
        this_window = frameDistances2[i: i+ window_size ]
        window_average = sum(this_window) / window_size
        moving_averages.append(window_average)
        i = i+1
    i = 0
    moving_averages2 = []
    while i < len(frameDistances1):
        this_window = frameDistances1[i : i+ window_size]
        window_average = sum(this_window) / window_size
        moving_averages2.append(window_average)
        i = i+1
    # print(dataz1)
    print('\n\n\n\n\n')
    print(counter_frame)
    print('\n\n\n\n\n')
    # print(frameDistances)
    # plt.plot(dataz1)
    # plt.savefig('dataz1.png')
    moving_averages1 = [(x + y)/2 for x, y in zip(moving_averages, moving_averages2)]
    plt.plot(frameDistances1, color="darkblue")
    plt.plot(frameDistances2, color="darkgreen")
    plt.plot(moving_averages1, color="darkorange", linewidth=3)
    # plt.plot(moving_averages2, color="orange", linewidth=3)
    # plt.show()

    plt.savefig('dataz-lk3-1.png')
