import cv2 as cv
import sys
import numpy as np
from numpy.linalg import norm
from operator import itemgetter, attrgetter
import cv2.aruco as aruco




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


#function that performs non-maximum supression
def non_max_supression(boxes, overlapThresh):
    i = len(boxes)-1

    if i > 1:
        while i > 0:	
            last = i - 1

            areaLast = boxes[last][4]
            areaNew = boxes[i][4]

            overlap = np.minimum(areaNew/areaLast, areaLast/areaNew)

            if overlap > overlapThresh:
                del boxes[i]

            i = i-1

    return boxes

#function that checks if there are three shapes in a row
def match_templates(patches):
    findMatch = 0
    for i in range(len(patches)-1):
        nextI = i+1
        patch = cv.cvtColor(patches[i], cv.COLOR_BGR2GRAY)
        patchNext = cv.cvtColor(patches[nextI], cv.COLOR_BGR2GRAY)
        try:
            match = cv.matchTemplate(patchNext, patch, cv.TM_CCOEFF_NORMED)
            if (len(match) != 0):
                findMatch = findMatch+1
            else:
                findMatch = 0
            if findMatch == 1:#it should be number of objects-1
                cv.imshow("a", patch)
                cv.imshow("b", patchNext)
                return 1, i, 
        except:
            print("An exception ocurred")
    return 0, 0	



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

def match_warped(squares, image):
    markers = []
    k = 0
    try:
        for i in range(len(squares)):
            contours = squares[i][6]
            #patch =  image[(squares[i][1]):(squares[i][1]+squares[i][3]), (squares[i][0]):(squares[i][0]+squares[i][2])]
            #contours, hierarchy = cv.findContours(patch, cv.RETR_LIST, cv.CHAIN_APPROX_NONE)
            draw2 = np.zeros((squares[i][5].shape[0], squares[i][5].shape[1], 3), dtype=np.uint8)
            #draw2 = np.zeros((patch.shape[0], patch.shape[1], 3), dtype=np.uint8)
            #cv.drawContours(draw2, contours, i, (0,255,0), 1, cv.LINE_8, hierarchy)
            #cv.imshow("Patch", draw2)

            white_square = squares[i][7]
            x,y,w,h = cv.boundingRect(white_square)
            area = cv.contourArea(white_square)


            patch = squares[i][5][x:x+w, y:y+h]

            contour_inside_warped, _ = cv.findContours(patch, cv.RETR_LIST, cv.CHAIN_APPROX_SIMPLE)

            for cnt_warped in contour_inside_warped:
                cnt_len = cv.arcLength(cnt_warped, True)
                contour_inside_warped = cv.approxPolyDP(cnt_warped, 0.02*cnt_len, True)

                contour_warped_area = cv.contourArea(cnt_warped)
                if contour_warped_area / area > 0.3 and contour_warped_area / area < 0.5:
                    markers.append(squares[i])
            """
            for cnt in contours:
                cnt_len = cv.arcLength(cnt, True)
                cnt = cv.approxPolyDP(cnt, 0.03*cnt_len, True)
                
                

                if len(cnt) == 4 and cv.isContourConvex(cnt):
                        cnt = cnt.reshape(-1, 2)
                        issquare = compare_distances(cnt)
                        if not(issquare):
                            continue

                        #cv.drawContours(draw2, contours, i, (0,255,0), 1, cv.LINE_8, hierarchy= None)

                        
                        #cv.imshow("desenho2", draw2)

                        #cv.waitKey(0)
                        #cv.destroyWindow('desenho2')

                        sumAngles = quad_sum(cnt)
                        if sumAngles != 360:
                            continue

                        x,y,w,h = cv.boundingRect(cnt)   

                        if x<0.2*squares[i][5].shape[0] or y<0.2*squares[i][5].shape[1]:
                            continue


                        draw = np.zeros((squares[i][5].shape[0], squares[i][5].shape[1], 3), dtype=np.uint8)
                        #cv.rectangle(squares[i][5], (x,y), (x+w,y+h), (0,255,0),1)

                        patch = squares[i][5][x:x+w, y:y+h]
                        #patch_medio = patch[x:x+w, y:y+h]
                        
                        #cv.imshow("path",patch)
                        
                        
                        cv.imshow("waq", squares[i][5])
                        #cv.waitKey(0)
                        #cv.destroyWindow('desenh')

                        contoursT, _ = cv.findContours(patch, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
                        for cntT in contoursT:
                            cntT_len = cv.arcLength(cntT, True)
                            cntT = cv.approxPolyDP(cntT, 0.02*cntT_len, True)
                            cntT = cntT.reshape(-1, 2)
                            
                            #if len(cntT) == 4:
                            for point in cntT: 
                                draw2 = cv.circle(draw2,  (point[0], point[1]), radius = 2, color = (0,255,0), thickness = -1)

                            issquare = compare_distances(cntT)
                            if len(cntT) == 3 or not(issquare):# and cv.countourArea(cnt) > 200:
                                markers.append(squares[i])
                        cv.imshow("desenh", draw2)
            """
        k = k+1
    except:
        print("erroe")
    return markers
def order_points(pts):
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

#####################################################################
img_markers = []
name = "markers/Markers_Novos/"  #PUT NAME OF IMAGE HERE
img_markers.append(cv.imread(name + "A1.jpeg"))
img_markers.append(cv.imread(name + "A2.jpeg"))
img_markers.append(cv.imread(name + "A3.jpeg"))
img_markers.append(cv.imread(name + "A4.jpeg"))
img_markers.append(cv.imread(name + "A5.jpeg"))
found = []

#parameters initialization
minPerimeterRate = 0.03
maxPerimeterRate = 4
minCornerDistanceRate = 0.05
minPerimeterPixels = minPerimeterRate * np.maximum(img_markers[0].shape[0], img_markers[0].shape[1])
maxPerimeterPixels = maxPerimeterRate * np.maximum(img_markers[0].shape[0], img_markers[0].shape[1])
parameters = aruco.DetectorParameters_create() ##S
minDistanceToBorder = parameters.minDistanceToBorder
minDistSq = np.maximum(img_markers[0].shape[0], img_markers[0].shape[1]) * np.maximum(img_markers[0].shape[0], img_markers[0].shape[1])

color = (0,255,0)


for i in range(5): 
    #grayscale

    img = img_markers[i]

    #resize imagem
    scale_percent = 40 # percent of original size
    width = int(img.shape[1] * scale_percent / 100)
    height = int(img.shape[0] * scale_percent / 100)
    dim = (width, height)   
    img = cv.resize(img, dim)

    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY) 

    #canny
    canny = cv.Canny(gray, 255/3, 255)

    #countours
    contours, hierarchy = cv.findContours(canny, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
    # Draw contours
    drawing = np.zeros((canny.shape[0], canny.shape[1], 3), dtype=np.uint8)
    for i in range(len(contours)):
        color = (0, 255, 0)
        cv.drawContours(drawing, contours, i, color, 1, cv.LINE_8, hierarchy, 0)
    # Show in a window
    cv.imshow('Contours', drawing)

    drawing2 = np.zeros((canny.shape[0], canny.shape[1], 3), dtype=np.uint8)

    squares = []
    triangles = []
    angle = 0
    for cnt in contours:
        cnt_len = cv.arcLength(cnt, True)
        cnt = cv.approxPolyDP(cnt, 0.02*cnt_len, True)
        if len(cnt) == 4  and cv.isContourConvex(cnt):

            
            cnt = cnt.reshape(-1, 2)          
            approxCurve = cnt
            sum_angles = quad_sum(cnt)
            minCornerDistancePixels = len(cnt) * minCornerDistanceRate
            
            for j in range(0,4):
                d = (approxCurve[j][0] - approxCurve[(j + 1)%4][0]) * (approxCurve[j][0] - approxCurve[(j + 1)%4][0]) + (approxCurve[j][1] - approxCurve[(j + 1)%4][1]) * (approxCurve[j][1] - approxCurve[(j + 1)%4][1])
                minDistSq = min(minDistSq, d)

            if sum_angles == 360 and minDistSq >= minCornerDistancePixels * minCornerDistancePixels:
                tooNearBorder = False
                for j in range(4):
                    if(approxCurve[j][0] < minDistanceToBorder or approxCurve[j][1] < minDistanceToBorder or approxCurve[j][0] > canny.shape[0] - 1 - minDistanceToBorder or approxCurve[j][1] > canny.shape[1] - 1 - minDistanceToBorder): 
                        tooNearBorder = True

                if(tooNearBorder): continue
                x,y,w,h = cv.boundingRect(cnt)


                cv.rectangle(drawing2, (x,y), (x+w,y+h), color, 2) 
                area = cv.contourArea(cnt)
                

                candidate_corner = []
                warped =[]
                for j in range(4):
                    candidate_corner.append([approxCurve[j][0], approxCurve[j][1]])
                
                candidate_corner = np.array(candidate_corner)
                candidate_corner = order_points(candidate_corner)
                warped = four_point_transform(gray, candidate_corner)
                _, warped = cv.threshold(warped, 125, 255, cv.THRESH_BINARY | cv.THRESH_OTSU)

                """
                #upscale patch
                scale_percent = 400 # percent of original size
                width = int(warped.shape[1] * scale_percent / 100)
                height = int(warped.shape[0] * scale_percent / 100)
                dim = (width, height)
                warped = cv.resize(warped, dim, interpolation = cv.INTER_AREA)
                """
                
                drawing3 = np.zeros((warped.shape[0], warped.shape[1], 3), dtype=np.uint8)

                
                contour_warped, _ = cv.findContours(warped, cv.RETR_LIST, cv.CHAIN_APPROX_SIMPLE)     

                white_square = []
                for cnt_warped in contour_warped:
                    contour_warped_len = cv.arcLength(cnt_warped, True)
                    contour_warped = cv.approxPolyDP(cnt_warped, 0.02*contour_warped_len, True)
                    contour_warped_area = cv.contourArea(cnt_warped)
                    if contour_warped_area / area > 0.25 and contour_warped_area/area < 0.5:
                        white_square = cnt_warped
                a = (x,y,w,h, area, warped, contour_warped, white_square)
                squares.append(a)
                for k in range(len(contour_warped)):
                    
                    cv.drawContours(drawing3, contour_warped, k, color, 1, cv.LINE_8)

                cv.imshow("draw3", warped)


        """
        if len(cnt) == 3:# and cv.countourArea(cnt) > 200:
            xt,yt,wt,ht = cv.boundingRect(cnt)
            areat = cv.contourArea(cnt)
            b = (xt,yt,wt,ht, areat)
            triangles.append(b)
        """

    #sorts every square and triangle, from smaller to bigger
    squares = sorted(squares, key=itemgetter(4))
    #triangles = sorted(triangles, key=itemgetter(4))

    #performs non maximum supression
    squares = non_max_supression(squares, 0.5)
    #triangles = non_max_supression(triangles, 0.5)

    markers = match_warped(squares, gray)

    if len(markers) > 0:
        found.append(1)    
    else:
        found.append(0)

    cv.imshow("desenho", drawing2)
    cv.waitKey(0)
    cv.destroyAllWindows()


np.savetxt('Marker_A.txt', found)

    

