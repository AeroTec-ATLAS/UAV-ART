import cv2 as cv
import numpy as np
import cv2.aruco as aruco
from operator import itemgetter, attrgetter

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


#Começar a captura
cap = cv.VideoCapture(0)
cap.set(3, 640)
cap.set(4, 480)
cap.set(10, 100)

#parameters initialization
sucess, img = cap.read()
params = aruco.DetectorParameters_create()
minDistSq = np.maximum(img.shape[0], img.shape[1]) * np.maximum(img.shape[0], img.shape[1])



while True:
    success, img = cap.read()

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
                
                #aux = (currentCandidate, cv.contourArea(cnt))
                #candidates.append(aux)  

          
        #cv.waitKey(0)
    



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
    print(groupedCandidates)
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
    


    #show squares in image
    for i in range(len(biggerCandidates)):
        x,y,w,h = cv.boundingRect(biggerCandidates[i])
        cv.rectangle(drawing, (x,y), (x+w,y+h), (255,0,0), 3)
    cv.imshow('Contours', drawing)
    


    #Quebrar se 'q' for premido
    if cv.waitKey(1) & 0xFF == ord('q'):
        break

    