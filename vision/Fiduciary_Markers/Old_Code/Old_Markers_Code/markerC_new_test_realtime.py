import cv2 as cv
import numpy as np
from numpy.linalg import norm
import cv2.aruco as aruco
from operator import itemgetter, attrgetter
import PIL

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
    k = 0
    for i in range(len(squares)):
        contours = squares[i][4]      
        draw2 = np.zeros((squares[i][5].shape[0], squares[i][5].shape[1], 3), dtype=np.uint8)

        for cnt in contours:
            cnt_len = cv.arcLength(cnt, True)
            cnt = cv.approxPolyDP(cnt, 0.03*cnt_len, True)

            if len(cnt) == 4 and cv.isContourConvex(cnt):
                cnt = cnt.reshape(-1, 2)
                issquare = compare_distances(cnt)
                if not(issquare):
                    continue

                x,y,w,h = cv.boundingRect(cnt)   
                
                if x<0.2*squares[i][5].shape[0] or y<0.2*squares[i][5].shape[1]:
                    continue

                if quad_sum(cnt) != 360:
                    continue

                areaBig = squares[i][5].shape[0] * squares[i][5].shape[1]
                areaSmall = cv.contourArea(cnt)
                if not(areaSmall/areaBig > 0.15 and areaSmall/areaBig < 0.35):
                    continue

                patch = squares[i][5]
                width = patch.shape[1]
                height = patch.shape[0]

                white = 0
                black = 0
                for w in range(width):
                    for h in range(height):
                        pixel = patch[h][w]

                        if (pixel == 255):
                            white += 1
                        else:
                            black += 1
                if black/white > 1.5 and black/white < 3:
                    markers.append(squares[i])   

            

        k = k+1
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

    if minimum_dist / maximum_dist > 0.8:
        result = True
    else:
        result = False

    return result

#function that calculates the sum of angles of a 4 line object
def quad_sum(cnt):
    sum_angles = 0

    p1 = np.array([cnt[0][0], cnt[0][1]])
    p2 = np.array([cnt[1][0], cnt[1][1]])
    p3 = np.array([cnt[2][0], cnt[2][1]])
    p4 = np.array([cnt[3][0], cnt[3][1]])

    p12 = p1-p2
    p23 = p2-p3
    p34 = p3-p4
    p41 = p4-p1

    cosine_angle1 = np.dot(p12, p23) / (np.linalg.norm(p12) * np.linalg.norm(p23))
    angle1 = np.degrees(np.arccos(cosine_angle1))

    cosine_angle2 = np.dot(p23, p34) / (np.linalg.norm(p23) * np.linalg.norm(p34))
    angle2 = np.degrees(np.arccos(cosine_angle2))

    cosine_angle3 = np.dot(p34, p41) / (np.linalg.norm(p34) * np.linalg.norm(p41))
    angle3 = np.degrees(np.arccos(cosine_angle3))

    cosine_angle4 = np.dot(p41, p12) / (np.linalg.norm(p41) * np.linalg.norm(p12))
    angle4 = np.degrees(np.arccos(cosine_angle4))

    sum_angles = angle1+angle2+angle3+angle4
    return sum_angles


########################################################################################
#Começar a captura
cap = cv.VideoCapture("C:/totalcmd/IST/UAV-ART/markers/New_Images/C_video.mp4")
cap.set(3, 640)
cap.set(4, 480)
cap.set(10, 100)

#parameters initialization
_, img = cap.read()
params = aruco.DetectorParameters_create()
minDistSq = np.maximum(img.shape[0], img.shape[1]) * np.maximum(img.shape[0], img.shape[1])


while True:
    sucess, img = cap.read()

    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY) 

    nScales = (params.adaptiveThreshWinSizeMax - params.adaptiveThreshWinSizeMin) / params.adaptiveThreshWinSizeStep+1
    nScales = round(nScales)

    candidates = []
    candidates_contours = []
    candidates_len = []
    for i in range(nScales):
        currScale = params.adaptiveThreshWinSizeMin + i*params.adaptiveThreshWinSizeStep
        
        threshImage = cv.adaptiveThreshold(gray, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY_INV, currScale, params.adaptiveThreshConstant)

        contours, hierarchy = cv.findContours(threshImage, cv.RETR_LIST, cv.CHAIN_APPROX_NONE)

        # Draw contours
        drawing = np.zeros((threshImage.shape[0], threshImage.shape[1], 3), dtype=np.uint8)
        for i in range(len(contours)):
            color = (0, 255, 0)
            cv.drawContours(drawing, contours, i, (0,255,0), 1, cv.LINE_8, hierarchy, 0)
        # Show in a window
   
        for cnt in contours:
            cnt_len = cv.arcLength(cnt, True)
            cnt_orig = cnt
            cnt = cv.approxPolyDP(cnt, params.polygonalApproxAccuracyRate*cnt_len, True)
            if len(cnt) == 4  and cv.contourArea(cnt) > 50 and cv.isContourConvex(cnt):
                cnt = cnt.reshape(-1, 2)     
                candidatesAux = []
                for i in range(4):
                    candidatesAux.append([cnt[i][0], cnt[i][1]])
                candidates.append(candidatesAux)
                candidates_contours.append(cnt_orig)
                candidates_len.append(cnt_len)

    #candidates = sorted(candidates, key=itemgetter(1))
    for i in range(len(candidates)):
        candidates[i] = order_points(candidates[i])


    candGroup = []
    #candGroup = np.array(candGroup)
    candGroup = [-1 for i in range(len(candidates))]
    #candGroup.resize(len(current_candidates), -1)
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
            biggerCandidates.append(candidates[biggerIdx])
            biggerContours.append(candidates_contours[biggerIdx])


    squares = []

    for i in range(len(biggerCandidates)):
        x,y,w,h = cv.boundingRect(biggerCandidates[i])
        cv.rectangle(drawing, (x,y), (x+w,y+h), (255,0,0), 3)

        warped = four_point_transform(gray, biggerCandidates[i])
        _, warped = cv.threshold(warped, 125, 255, cv.THRESH_BINARY | cv.THRESH_OTSU)
        contour_warped, _ = cv.findContours(warped, cv.RETR_LIST, cv.CHAIN_APPROX_NONE)  

        aux = (x,y,w,h,contour_warped, warped)
        squares.append(aux)
   
    markers = match_warped(squares, gray)
    
    

    for i in range(len(markers)):
        x1 = markers[i][0]
        y1 = markers[i][1]
        w = markers[i][2]
        h = markers[i][3]
        cv.rectangle(img, (x1,y1), (x1+w,y1+h), (0,255,0),10)
    
    cv.imshow("window", img)

        

    cv.imshow('Contours', drawing)
    

    

    #Quebrar se 'q' for premido
    if cv.waitKey(1) & 0xFF == ord('q'):
        break

    