import cv2 as cv
import sys
import numpy as np
from operator import itemgetter, attrgetter


#function that calculates the sum of angles of a 4 line object
def quad_sum(cnt):
    sum_angles = 0
    x1 = cnt[0][0]
    x2 = cnt[1][0]
    x3 = cnt[2][0]
    x4 = cnt[3][0]
    y1 = cnt[0][1]
    y2 = cnt[1][1]
    y3 = cnt[2][1]
    y4 = cnt[3][1]

    angle = np.rad2deg(np.arctan2(cnt[1][1]-cnt[0][1], cnt[1][0]-cnt[0][0]))


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
                print("FIND")
                findMatch = findMatch+1
            else:
                findMatch = 0
                print("NOT")
            if findMatch == 1:#it should be number of objects-1
                return 1, i
        except:
            print("An exception ocurred")
    return 0, 0	


#####################################################################

#Começar a captura
cap = cv.VideoCapture(0)
cap.set(3, 640)
cap.set(4, 480)
cap.set(10, 100)





while True:
    success, img = cap.read()

    """
    #resize imagem
    scale_percent = 50 # percent of original size
    width = int(img.shape[1] * scale_percent / 100)
    height = int(img.shape[0] * scale_percent / 100)
    dim = (width, height)   
    img = cv.resize(img, dim)
    """

    #grayscale
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY) 

    #canny
    canny = cv.Canny(gray, 255/3, 255)

    #dillation
    kernel = np.ones((3,3),np.uint8)
    canny = cv.dilate(canny,kernel,iterations = 1)

    #countours
    contours, hierarchy = cv.findContours(canny, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
    
    # Draw contours
    drawing = np.zeros((canny.shape[0], canny.shape[1], 3), dtype=np.uint8)
    for i in range(len(contours)):
        color = (0, 255, 0)
        cv.drawContours(drawing, contours, i, color, 1, cv.LINE_8, hierarchy, 0)
    # Show in a window
    cv.imshow('Contours', drawing)

    squares = []
    triangles = []
    angle = 0
    for cnt in contours:
        cnt_len = cv.arcLength(cnt, True)
        cnt = cv.approxPolyDP(cnt, 0.02*cnt_len, True)
        if len(cnt) == 4 and cv.contourArea(cnt) > 200:
            cnt = cnt.reshape(-1, 2)
            #angle = np.rad2deg(np.arctan2(cnt[1][1]-cnt[0][1], cnt[1][0]-cnt[0][0]))
            #if (angle>88 and angle<92) or (angle>-2 and angle<2) or (angle>178 and angle<182) or (angle>268 and angle<272):          
            sum_angles = quad_sum(cnt)
            if sum_angles > 355 and sum_angles < 365:
                x,y,w,h = cv.boundingRect(cnt)
                area = cv.contourArea(cnt)
                a = (x,y,w,h, area)
                squares.append(a)
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
   # triangles = non_max_supression(triangles, 0.5)

    #join squares and triangles and orders them
    shapes = []
    shapes = squares #+ triangles
    shapes = sorted(shapes, key=itemgetter(4))


    #now, to find the marker (triangle inside square inside square)
    i = len(shapes)-1
    patch = []
    while(i >= 0):
        patch.append(img[(shapes[i][1]):(shapes[i][1]+shapes[i][3]), (shapes[i][0]):(shapes[i][0]+shapes[i][2])])
        i=i-1

    res, idx = match_templates(patch)

    if res == 1:#finds marker
        x1 = shapes[i][0]
        y1 = shapes[i][1]
        w = shapes[i][2]
        h = shapes[i][3]

        cv.rectangle(img, (x1,y1), (x1+w,y1+h), (0,255,0),1)


    cv.imshow("window", img)


    #Quebrar se 'q' for premido
    if cv.waitKey(1) & 0xFF == ord('q'):
        break

