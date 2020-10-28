import cv2
import numpy as np
import argparse
import math
import matplotlib.pyplot as plt
from operator import itemgetter
##################### INITIAL CONDITIONS ###################################
clickcon = 0
global mouseX,mouseY
global initial_state
global initial_state2
global newd1
initial_state = 1
initial_state2 = 1


def distance(x0,y0,x1,y1):
    r = math.sqrt( ((x1-x0)**2)+((y1-y0)**2) )
    return r

def selection_sort(x):
    for i in range(len(x)):
        swap = i + np.argmin(x[i:])
        (x[i], x[swap]) = (x[swap], x[i])
    return x




par = 0

##################### VIDEO ################################################
cap = cv2.VideoCapture(0)

descriptorlist = []
CONDITION1=0
distlist = []

while(cap.isOpened()):

  ret, frame = cap.read()
  if ret == True:
#################### MOUSE CLICK #########################################

      def click_event(event, x, y, flags, param):
          global mouseX,mouseY
          global initial_state
          global initial_state2
          if event == cv2.EVENT_LBUTTONDOWN:
              mouseX,mouseY = x,y
              initial_state2 = 0
              initial_state = 0
          if event == cv2.EVENT_RBUTTONDOWN:
              initial_state = 1 #Reinicia os keypoints

################ DETECTOR #######################################################
      if initial_state == 0:
        print(mouseX, mouseY)
      sift = cv2.xfeatures2d.SIFT_create()
      kp1, d1 = sift.detectAndCompute(frame,None)
      u = len(kp1)
      poskp1 = []
      z=0

      while z < u:
          poskp1.append([kp1[z].pt])
          z=z+1

############## DISTANCE KP TO MOUSE ##################################################

      if initial_state2 == 0:
          kp_dist = []
          counter = 0
          for element in kp1:
            dist = math.sqrt( ((float(mouseX)-element.pt[0])**2)+((float(mouseY)-element.pt[1])**2) )
            kp_dist.append([dist, counter])
            counter = counter + 1

          number_kp = 25
          kp_dist = np.array(kp_dist)
          newkp1 = []
          #
          kp_dist = sorted(kp_dist, key=itemgetter(0))
          kp_dist = kp_dist[:number_kp]
          # print(kp_dist)
          counter = 0
          newd1 = []

          while counter < len(kp_dist):
              numero = int(kp_dist[counter][1])
              counter = counter + 1
              desc = d1[numero]
              newd1.append(desc)


      if (initial_state)!= 0:
        frame = cv2.drawKeypoints(frame,kp1,None,flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)


################ MATCHER #######################################################


      if initial_state == 0 and initial_state2!=0:

          newd1 = np.array(newd1, dtype=np.float32)
          print(newd1)
          # print(len(d1))
          matcher = cv2.DescriptorMatcher_create(cv2.DescriptorMatcher_FLANNBASED)
          knn_matches = matcher.knnMatch(newd1, d1, 2)
          # print(eudistlist)
          # print(len(knn_matches))

          ratio_thresh = 0.65
          good = []
          dist = []
          for m,n in knn_matches:
              if m.distance < ratio_thresh * n.distance:
                  good.append(m)

          i = 0
          newkeypoints1 = []
          while i < len(good):
              keypoint = good[i].trainIdx
              keypoint1 = kp1[keypoint]
              newkeypoints1.append(keypoint1)
              # print(newkeypoints1[i].size)
              i = i+1



          i = 0
          while i < len(newkeypoints1):# cv2.putText(frame,"x", (int(newkeypoints1[i].pt[0]), int(newkeypoints1[i].pt[1])), cv2.FONT_HERSHEY_SIMPLEX, 1, 255)
              frame = cv2.circle(frame, (int(newkeypoints1[i].pt[0]), int(newkeypoints1[i].pt[1])), int(newkeypoints1[i].size), (0,144,255), 2)
              i = i+1nts1,None,flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)




################ SHOW IMAGES #######################################################

      cv2.namedWindow('Frame', cv2.WINDOW_GUI_NORMAL)
      cv2.imshow('Frame',frame)

      descriptorlist.append(d1)
      descriptorlistframeantigo = [d1]

      CONDITION1=1
      initial_state2 = 1
      cv2.setMouseCallback("Frame", click_event)
      if cv2.waitKey(25) & 0xFF == ord('q'):
          break
  else:
      break


cap.release()
