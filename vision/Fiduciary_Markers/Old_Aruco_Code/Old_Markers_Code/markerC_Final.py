import cv2 as cv
import numpy as np
from numpy.linalg import norm
import math
import cv2.aruco as aruco
import matplotlib.pyplot as plt
from operator import itemgetter, attrgetter
import PIL
import timeit
import datetime

def order_points(pts):
    pts = np.array(pts)
    # initialzie a list of coordinates that will be ordered
    # such that the first entry in the list is the top-left,
    # the second entry is the top-right, the third is the
    # bottom-right, and the fourth is the bottom-left
    rect = np.zeros((4, 2), dtype = "float32")
    # the top-left point will have the smallest sum, whereas
    # the bottom-right point will have the largest sum
    s = pts.sum(axis = 1)
    rect[0] = pts[np.argmin(s)]
    rect[2] = pts[np.argmax(s)]
    # now, compute the difference between the points, the
    # top-right point will have the smallest difference,
    # whereas the bottom-left will have the largest difference
    diff = np.diff(pts, axis = 1)
    rect[1] = pts[np.argmin(diff)]
    rect[3] = pts[np.argmax(diff)]
    # return the ordered coordinates
    return rect

def four_point_transform(image, pts):
	# obtain a consistent order of the points and unpack them
	# individually
	rect = order_points(pts)
	(tl, tr, br, bl) = rect
	# compute the width of the new image, which will be the
	# maximum distance between bottom-right and bottom-left
	# x-coordiates or the top-right and top-left x-coordinates
	widthA = np.sqrt(((br[0] - bl[0]) ** 2) + ((br[1] - bl[1]) ** 2))
	widthB = np.sqrt(((tr[0] - tl[0]) ** 2) + ((tr[1] - tl[1]) ** 2))
	maxWidth = max(int(widthA), int(widthB))
	# compute the height of the new image, which will be the
	# maximum distance between the top-right and bottom-right
	# y-coordinates or the top-left and bottom-left y-coordinates
	heightA = np.sqrt(((tr[0] - br[0]) ** 2) + ((tr[1] - br[1]) ** 2))
	heightB = np.sqrt(((tl[0] - bl[0]) ** 2) + ((tl[1] - bl[1]) ** 2))
	maxHeight = max(int(heightA), int(heightB))
	# now that we have the dimensions of the new image, construct
	# the set of destination points to obtain a "birds eye view",
	# (i.e. top-down view) of the image, again specifying points
	# in the top-left, top-right, bottom-right, and bottom-left
	# order
	dst = np.array([
		[0, 0],
		[maxWidth - 1, 0],
		[maxWidth - 1, maxHeight - 1],
		[0, maxHeight - 1]], dtype = "float32")
	# compute the perspective transform matrix and then apply it
	M = cv.getPerspectiveTransform(rect, dst)
	warped = cv.warpPerspective(image, M, (maxWidth, maxHeight))
	# return the warped image
	return warped


def match_warped(squares, image):
    markers = []
    for i in range(len(squares)):
        patch = squares[i][4]
        width = patch.shape[1]
        height = patch.shape[0]

        white = 1
        black = 0
        nPixel = 0
        
        for h in range(round(0.4*height), round(0.6*height)):
            for w in range(round(0.4*width), round(0.6*width)):
                pixel = patch[h][w]
                nPixel += 1
                if (pixel == 255):
                    white += 1
                else:
                    black += 1
        if black/white < 0.05:
            black = 0
            white = 0
            for w in range(width):
                for h in range(height):
                    pixel = patch[h][w]
                    if (pixel == 255):
                        white += 1
                    else:
                        black += 1
            if black > white:
                cv.imshow("aq", squares[i][4])
                markers.append(squares[i])
    return markers

def compare_distances(cnt):
    try:
        p1 = np.array([cnt[0][0], cnt[0][1]])
        p2 = np.array([cnt[1][0], cnt[1][1]])
        p3 = np.array([cnt[2][0], cnt[2][1]])
        p4 = np.array([cnt[3][0], cnt[3][1]])
    except:
        result = False
        return result

    p12 = norm(p1-p2)
    p23 = norm(p2-p3)
    p34 = norm(p3-p4)
    p41 = norm(p4-p1)
    
    minimum_dist = min(p12, p23, p34, p41)
    maximum_dist = max(p12, p23, p34, p41)

    if minimum_dist / maximum_dist > 0.4:
        result = True
    else:
        result = False

    return result

def isRotationMatrix(R): # This function checks if a Matrix is a valid rotation matrix.
    
    Rt = np.transpose(R)
    shouldBeIdentity = Rt @ R
    I = np.identity(3, dtype=R.dtype)
    n = np.linalg.norm(I -shouldBeIdentity)
    return n < 1e-6

def rotationMatrixToEulerAngles(R): # This function converts rotation matrices to Euler angles.
    assert (isRotationMatrix(R))
    sy = math.sqrt(R[0, 0] * R[0, 0] + R[1, 0] * R[1, 0])
    singular = sy < 1e-6
    if not singular:
        x = math.atan2(R[2, 1], R[2, 2])
        y = math.atan2(-R[2, 0], sy)
        z = math.atan2(R[1, 0], R[0, 0])
    else:
        x = math.atan2(-R[1, 2], R[1, 1])
        y = math.atan2(-R[2, 0], sy)
        z = 0
    return np.array([x, y, z])

def computeMarker(img, flagFound, bbox):
    #bbox = (0,0,0,0)
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY) 

    candidates = []
    candidates_contours = []
    candidates_len = []
   
    threshImage = cv.adaptiveThreshold(gray,255,cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY,5,3)

    contours, hierarchy = cv.findContours(threshImage, cv.RETR_LIST, cv.CHAIN_APPROX_NONE)
    drawing = np.zeros((threshImage.shape[0], threshImage.shape[1], 3), dtype=np.uint8)
    for cnt in contours:
        cnt_len = cv.arcLength(cnt, True)
        cnt_orig = cnt
        cnt = cv.approxPolyDP(cnt, params.polygonalApproxAccuracyRate*cnt_len, True)
        if len(cnt) == 4  and cv.contourArea(cnt) > 80 and cv.contourArea(cnt) < 0.2*width*height  and cv.isContourConvex(cnt):
            cv.drawContours(drawing, contours, 1, (0,255,0), 1, cv.LINE_8, hierarchy, 0)

            cnt = cnt.reshape(-1, 2)     
            candidatesAux = []
            for i in range(4):
                candidatesAux.append([cnt[i][0], cnt[i][1]])
            candidates.append(candidatesAux)
            candidates_contours.append(cnt_orig)
            candidates_len.append(cnt_len)

    for i in range(len(candidates)):
        candidates[i] = order_points(candidates[i])

    candGroup = []
    candGroup = [-1 for i in range(len(candidates))]
    groupedCandidates = []
    
    for i in range(len(candidates)):
        for j in range(1,len(candidates)):
            minimum_perimeter = min(len(candidates_contours[i]), len(candidates_contours[j]))
            for fc in range(4):
                distsq=0
                for c in range(4):
                    modC = (c+fc)%4
                    distsq = distsq + (candidates[i][modC][0] - candidates[j][c][0])**2 +  (candidates[i][modC][1] - candidates[j][c][1])**2
                distsq = distsq/4.0
                minMarkerDistancePixels = float(minimum_perimeter)*params.minMarkerDistanceRate
                if(distsq < minMarkerDistancePixels**2):
                    if(candGroup[i]<0 and candGroup[j]<0):
                        candGroup[i] = candGroup[j] = (int)(len(groupedCandidates))
                        grouped = []
                        grouped.append(i)
                        grouped.append(j)
                        groupedCandidates.append(grouped)
                    elif(candGroup[i] > -1 and candGroup[j] == -1):
                        group = candGroup[i]
                        candGroup[j] = group
                        groupedCandidates[group].append(j)
                    elif(candGroup[j] > -1 and candGroup[i] == -1):
                        group = candGroup[j]
                        candGroup[i] = group
                        groupedCandidates[group].append(i)
    
    biggerCandidates = []
    biggerContours = []
    for i in range(len(groupedCandidates)):
        smallerIdx = groupedCandidates[i][0]
        biggerIdx = -1
        for j in range(1, len(groupedCandidates[i])):
            currPerim = candidates_len[ groupedCandidates[i][j] ]
            if biggerIdx < 0:
                biggerIdx = groupedCandidates[i][j]
            elif(currPerim >= len(candidates_contours[ biggerIdx ])):
                biggerIdx = groupedCandidates[i][j]
            
            if(currPerim < len(candidates_contours[ smallerIdx ])):
                smallerIdx = groupedCandidates[i][j]

        if (biggerIdx > -1):
            cnt = candidates[biggerIdx].reshape(-1, 2)
            issquare = compare_distances(cnt)
            if not(issquare):
                continue
            biggerCandidates.append(candidates[biggerIdx])
            biggerContours.append(candidates_contours[biggerIdx])


    squares = []

    for i in range(len(biggerCandidates)):
        x,y,w,h = cv.boundingRect(biggerCandidates[i])

        cv.rectangle(drawing, (x,y), (x+w,y+h), (255,0,0), 3)

        warped = four_point_transform(gray, biggerCandidates[i])

        _, warped = cv.threshold(warped, 125, 255, cv.THRESH_BINARY | cv.THRESH_OTSU)
        #_, warped = cv.threshold(warped, 125, 255, cv.THRESH_BINARY)
        
        aux = (x,y,w,h, warped, biggerCandidates[i])
        squares.append(aux)
    
    markers = match_warped(squares, gray)
    
    foundMarker = False
    for i in range(len(markers)):
        x1 = markers[i][0]
        y1 = markers[i][1]
        w = markers[i][2]
        h = markers[i][3]
        corners = markers[i][5]
        cv.rectangle(img, (x1,y1), (x1+w,y1+h), (0,255,0),10)
        foundMarker = True

        try:

            _, rvec, tvec = cv.solvePnP(object_points, corners, camera_matrix, camera_distortion, flags = cv.SOLVEPNP_IPPE_SQUARE)
            marker_distance = np.linalg.norm(tvec)
            R_ct = np.matrix(cv.Rodrigues(rvec)[0]) # rotation matrix of camera wrt marker.

            R_tc = R_ct.T # rotation matrix of marker wrt camera
            roll_marker, pitch_marker, yaw_marker = rotationMatrixToEulerAngles(R_Flip*R_tc)
            str_position = "Marker Position: x = %4.0f y = %4.0f z = %4.0f"%(tvec[0], tvec[1], tvec[2])
            cv.putText(img, str_position, (0, 100), font, 0.5, (255,0,0), 2, cv.LINE_AA)

            str_distance = "Marker Distance: d = %4.0f"%(marker_distance)
            cv.putText(img, str_distance, (0, 150), font, 0.5, (255,0,0), 2, cv.LINE_AA)

            str_attitude = "Marker Attitude r=%4.0f p=%4.0f y=%4.0f"%(math.degrees(roll_marker),math.degrees(pitch_marker),math.degrees(yaw_marker))
            cv.putText(img, str_attitude, (0, 200), font, 0.5, (255,0,0), 2, cv.LINE_AA)

            str_flagFound = "Flag Found = " + str(flagFound)
            cv.putText(img, str_flagFound, (0, 250), font, 0.5, (255,0,0), 2, cv.LINE_AA)

            data.append(marker_distance)

            if flagFound == 0:
                flagFound = flagFound + 5
            else:
                flagFound = flagFound+1
            bbox = (x1, y1, w, h)
        except:
            marker_distance = 0
            print("error")
    if foundMarker == False:
        if flagFound > 1:
            flagFound = flagFound-1
        else:
            flagFound = 0
    return img, drawing, flagFound, bbox

########################################################################################
########################################################################################
#Começar a captura
marker_size = 11
#Santi
#calib_path = 'D:/Desktop/IST/UAV/Visao/'
#Vasco 
calib_path = 'C:/totalcmd/IST/UAV-ART/markers/'
camera_matrix = np.loadtxt(calib_path+'Camera_Matrix_iPhone.txt', delimiter =',')
camera_distortion = np.loadtxt(calib_path+'Camera_Distortion_iPhone.txt', delimiter =',')


font = cv.FONT_HERSHEY_SIMPLEX

R_Flip = np.zeros((3,3), dtype = np.float32)
R_Flip[0,0] = 1.0
R_Flip[1,1] = -1.0
R_Flip[2,2] = -1.0

object_points = []
object_points.append( [float(-marker_size / 2),float(marker_size / 2), 0])
object_points.append( [float(marker_size / 2),float(marker_size / 2), 0])
object_points.append(  [float(marker_size / 2),float(-marker_size / 2), 0])
object_points.append(  [float(-marker_size / 2),float(-marker_size / 2), 0])
object_points = np.array(object_points)

data = []
Save = False

cap = cv.VideoCapture()
cap.set(3, 640)
cap.set(4, 480)
cap.set(10, 100)


img_markers = []
name = "markers/New_Images/"  #PUT NAME OF IMAGE HERE
img_markers.append(cv.imread(name + "C1.jpeg"))
img_markers.append(cv.imread(name + "C2.jpeg"))
img_markers.append(cv.imread(name + "C3.jpeg"))
img_markers.append(cv.imread(name + "C4.jpeg"))
img_markers.append(cv.imread(name + "C5.jpeg"))
img_markers.append(cv.imread(name + "C6.jpeg"))
img_markers.append(cv.imread(name + "C7.jpeg"))
found = []


#parameters initialization
#img = img_markers[0]
cap = cv.VideoCapture("C:/totalcmd/IST/UAV-ART/markers/New_Images/C_fastq.MOV")

suc, img = cap.read()

params = aruco.DetectorParameters_create()
minDistSq = np.maximum(img.shape[0], img.shape[1]) * np.maximum(img.shape[0], img.shape[1])
color = (0, 255, 0)

marker_distance = 0
exit = False
count3 = 0
count2 = 0
count1 = 0

numframe = 0
flagFound = 0
bbox = (0,0,0,0)

trackerIsInit = False
countFrame = 0

#CHANGE IS SCALE AND CAMERA MATRIX
scale_percent = 150
scale_camera = scale_percent / 100
camera_matrix[0][0] = camera_matrix[0][0] * scale_camera
camera_matrix[0][2] = camera_matrix[0][2] * scale_camera
camera_matrix[1][1] = camera_matrix[1][1] * scale_camera
camera_matrix[1][2] = camera_matrix[1][2] * scale_camera

while True:
    sucess, img = cap.read()
    if not(sucess):
        break
    
    width = int(img.shape[1] * scale_percent / 100)
    height = int(img.shape[0] * scale_percent / 100)
    dim = (width, height)
    
    img = cv.resize(img, dim)

    if flagFound > 1:
        x = bbox[0]
        y = bbox[1]
        w = bbox[2]
        h = bbox[3]

        mask = np.full((img.shape[0], img.shape[1]), 0, dtype=np.uint8)
        cv.rectangle(mask, (x-w, y-h), (x+2*w, y+2*h), 255, -1)
        img = cv.bitwise_and(img, img, mask=mask)

     
    img, drawing, flagFound, bbox = computeMarker(img, flagFound, bbox)

    cv.imshow("window", img)
    cv.imshow('Contours', drawing)

    
    #cv.waitKey(0)
    #cv.destroyAllWindows()
    
    #Quebrar se 'q' for premido
    if cv.waitKey(1) & 0xFF == ord('q'):
        break


if data:
    plt.plot(data)
    plt.show()
    if Save:
        np.savetxt('Results_M3.txt', data, fmt='%f')
    
"""
if marker_distance > 400:
count3 += 1
if count3 == 30:
    scale_percent = 150
    count3 = 0
    count2 = 0
    count1 = 0
elif marker_distance >= 250 and marker_distance <= 400 :
count2 += 1
if count2 == 30:
    scale_percent = 100
    count3 = 0
    count2 = 0
    count1 = 0
elif marker_distance < 250:
count1 += 1
if count1 == 30:
    scale_percent = 60
    count3 = 0
    count2 = 0
    count1 = 0
"""