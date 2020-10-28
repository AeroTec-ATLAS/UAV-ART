import cv2
import numpy as np
import random
from operator import itemgetter

initial_state=0

font = cv2.FONT_HERSHEY_SIMPLEX

colors = [(0, 0, 255), (255, 0, 255), (255, 0, 145), (255, 0, 0), (0, 255, 0), (255, 255, 0)]

names = ['select video 1', 'select video 2']

cap = [cv2.VideoCapture(i) for i in names]

frames = [None] * len(names);
ret = [None] * len(names);

while True:

    for i,c in enumerate(cap):
        if c is not None:
            ret[i], frames[i] = c.read();


    for i,f in enumerate(frames):
        if ret[i] is True:
            sift = cv2.xfeatures2d.SIFT_create()
            kp1, d1 = sift.detectAndCompute(frames[0],None)
            kp2, d2 = sift.detectAndCompute(frames[1],None)

            ####### MATCHING ##########
            matcher = cv2.DescriptorMatcher_create(cv2.DescriptorMatcher_FLANNBASED)
            if initial_state==1:
                firstd1 = np.array(firstd1, dtype=np.float32)
                knn_matches1 = matcher.knnMatch(firstd1, d1, 2)

                ratio_thresh = 0.7
                good1 = []
                for m,n in knn_matches1:
                    if m.distance < ratio_thresh * n.distance:
                        good1.append(m)

                i = 0
                newkeypoints1 = []
                newd1 = []
                novalista = []
                while i < len(good1):

                    numero = good1[i].trainIdx
                    newkp = kp1[numero]
                    newkeypoints1.append(newkp)
                    desc = d1[numero]
                    newd1.append(desc)
                    novalista.append((numero, desc))

                    i=i+1




            if initial_state==0:
                knn_matches2 = matcher.knnMatch(d1, d2, 2)
            if initial_state==1:
               newd1 = np.array(newd1, dtype=np.float32)
               knn_matches2 = matcher.knnMatch(newd1, d2, 2)
            if initial_state==0:
                ratio_thresh = 0.4
            if initial_state==1:
                ratio_thresh = 0.7
            good2 = []
            for m,n in knn_matches2:
                if m.distance < ratio_thresh * n.distance:
                    good2.append(m)

            if initial_state==0:
                good2 = good2[:6]

            img3 = np.hstack((frames[0], frames[1]))

            i = 0
            if initial_state == 0:
                newkeypointsK = []
            newkeypoints2 = []
            if initial_state==1:
                newkeypointsK = []
                newlistacor = []
            if initial_state == 0:
                firstd1 = []
                listacor = []
            keypoint = 0
            while i < len(good2):
                if initial_state == 0:
                    keypoint3 = good2[i].queryIdx
                    keypoint1 = kp1[keypoint3]
                    newdescriptors = d1[keypoint3]
                    firstd1.append(newdescriptors)
                    listacor.append((newdescriptors, i))
                    newkeypointsK.append(keypoint1)
                if initial_state == 1:
                    p = 0
                    keypoint3 = good2[i].queryIdx
                    while p<len(good1):
                        new = good1[p].trainIdx
                        new1 = d1[new]
                        # print('\n')
                        z = 0
                        while z<len(good2):
                            keypoint = good2[z].queryIdx
                            new2 = newd1[keypoint]
                            # print('\n\n\n\n')
                            comparison1 = new1 == new2
                            equal = comparison1.all()

                            if equal==1:
                                print('passou')
                                aaa = good1[p].queryIdx
                                aaa2 = listacor[aaa][1]
                                newlistacor.append(aaa2)
                            z=z+1
                        p=p+1

                    keypoint1 = newd1[keypoint3]
                    x=0
                    while x<len(novalista):
                        # print(keypoint1)
                        # print(novalista[x][1])
                        # print("\n\n\n\n")
                        comparison = novalista[x][1] == keypoint1
                        equal_arrays = comparison.all()
                        if equal_arrays==1:
                            # print('passou')
                            keypoint = novalista[x][0]
                            keypoint1 = kp1[keypoint]
                            newkeypointsK.append(keypoint1)
                        x = x+1
                keypoint = good2[i].trainIdx
                keypoint2 = kp2[keypoint]
                newkeypoints2.append(keypoint2)
                i=i+1

            if initial_state==1:
                print(newlistacor)
            i=0
            while i <len(newkeypointsK) and i<len(newkeypoints2):
                if initial_state==1:
                    aaaaa = newlistacor[i]
                if initial_state==0:
                    aaaaa = i
                frames[0]= cv2.circle(frames[0], (int(newkeypointsK[i].pt[0]), int(newkeypointsK[i].pt[1])), 30, colors[aaaaa], 20)
                frames[1] = cv2.circle(frames[1], (int(newkeypoints2[i].pt[0]), int(newkeypoints2[i].pt[1])), 30, colors[aaaaa], 20)
                print(i)
                i=i+1


            img3 = np.hstack((frames[0], frames[1]))
            cv2.namedWindow('Frame', cv2.WINDOW_GUI_NORMAL)
            cv2.imshow('Frame',img3)

            initial_state = 1
    if cv2.waitKey(1) & 0xFF == ord('q'):
       break


for c in cap:
    if c is not None:
        c.release();

cv2.destroyAllWindows()
