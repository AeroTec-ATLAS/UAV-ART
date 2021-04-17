import cv2 as cv
import sys
import imutils
import math
import numpy as np


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

#Começar a captura
cap = cv.VideoCapture(0)
cap.set(3, 640)
cap.set(4, 480)
cap.set(10, 100)

#######
DICTNAME = cv.aruco.DICT_4X4_50 #REPLACE HERE
arucoDict = cv.aruco.Dictionary_get(DICTNAME)
arucoParams = cv.aruco.DetectorParameters_create()

R_Flip = np.zeros((3,3), dtype = np.float32)
R_Flip[0,0] = 1.0
R_Flip[1,1] = -1.0
R_Flip[2,2] = -1.0

marker_size = np.float32(9) #cm
calib_path = 'markers/'
camera_matrix = np.loadtxt(calib_path+'Camera_Matrix.txt', delimiter =',')
camera_distortion = np.loadtxt(calib_path+'Camera_Distortion.txt', delimiter =',')

font = cv.FONT_HERSHEY_SIMPLEX

bf = cv.BFMatcher(cv.NORM_L1, crossCheck=False)

flagTrack = False

while True:
    success, img = cap.read()

    if success == False:
        break

    #detect the markers
    if flagTrack == False:
        (corners, ids, rejected) = cv.aruco.detectMarkers(img, arucoDict, parameters=arucoParams)

        if len(corners) > 0:
            #flatten arucos ids
            ids = ids.flatten()

            #loop over detected aruco corners
            for (markerCorner, markerID) in zip(corners, ids):

                corners_q = markerCorner.reshape((4,2))
                (topLeft, topRight, bottomRight, bottomLeft) = corners_q
                #convert each of the (x, y)-coordinate pairs to integers
                topRight = (int(topRight[0]), int(topRight[1]))
                bottomRight = (int(bottomRight[0]), int(bottomRight[1]))
                bottomLeft = (int(bottomLeft[0]), int(bottomLeft[1]))
                topLeft = (int(topLeft[0]), int(topLeft[1]))

                #draw bounding box
                cv.line(img, topLeft, topRight, (0, 255, 0), 2)
                cv.line(img, topRight, bottomRight, (0, 255, 0), 2)
                cv.line(img, bottomRight, bottomLeft, (0, 255, 0), 2)
                cv.line(img, bottomLeft, topLeft, (0, 255, 0), 2)


                # compute and draw the center (x, y)-coordinates of the ArUco
                # marker
                cX = int((topLeft[0] + bottomRight[0]) / 2.0)
                cY = int((topLeft[1] + bottomRight[1]) / 2.0)
                cv.circle(img, (cX, cY), 4, (0, 0, 255), -1)
                # draw the ArUco marker ID on the image
                cv.putText(img, str(markerID), (topLeft[0], topLeft[1] - 15), cv.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)
                #print("[INFO] ArUco marker ID: {}".format(markerID))

                cv.circle(img, topLeft, 4, (255, 0, 0), -1)
                cv.circle(img, topRight, 4, (0, 255, 0), -1)
                cv.circle(img, bottomRight, 4, (0, 0, 255), -1)
                cv.circle(img, bottomLeft, 4, (255, 255, 255), -1)
                """
                ret = cv.aruco.estimatePoseSingleMarkers(corners, marker_size, camera_matrix, camera_distortion )
                
                rvec, tvec = ret[0][0,0,:], ret[1][0,0,:] #Rodrigues rotation vector 

                marker_distance = np.linalg.norm(tvec)
                R_ct = np.matrix(cv.Rodrigues(rvec)[0]) # rotation matrix of camera wrt marker.
                #print(R_ct)
                R_tc = R_ct.T # rotation matrix of marker wrt camera
                roll_marker, pitch_marker, yaw_marker = rotationMatrixToEulerAngles(R_Flip*R_tc)
                cv.aruco.drawDetectedMarkers(img, corners)
                
                cv.aruco.drawAxis(img, camera_matrix, camera_distortion, rvec, tvec, 10)
                str_position = "Marker Position: x = %4.0f y = %4.0f z = %4.0f"%(tvec[0], tvec[1], tvec[2])
                cv.putText(img, str_position, (0, 100), font, 0.5, (255,0,0), 2, cv.LINE_AA)

                str_distance = "Marker Distance: d = %4.0f"%(marker_distance)
                cv.putText(img, str_distance, (0, 150), font, 0.5, (255,0,0), 2, cv.LINE_AA)

                str_attitude = "Marker Attitude r=%4.0f p=%4.0f y=%4.0f"%(math.degrees(roll_marker),math.degrees(pitch_marker),math.degrees(yaw_marker))
                cv.putText(img, str_attitude, (0, 200), font, 0.5, (255,0,0), 2, cv.LINE_AA)

                #tracker
                #print(corners_q[0])
                print(topLeft, topRight, bottomRight, bottomLeft)
                bbox = (int(topLeft[0]), int(topLeft[1]), int(topRight[0]-topLeft[0]), int(topRight[1]-bottomRight[1]))
                print(bbox)
                tracker = cv.TrackerCSRT_create()
                tracker.init(img, bbox)
                flagTrack = True
    else:
        ok, bbox = tracker.update(img)

        if ok:
                #Tracking succes
                pt1 = (int(bbox[0]), int(bbox[1]))
                pt2 = (int(bbox[0] + bbox[2]), int(bbox[1] + bbox[3]))
                cv.rectangle(img, pt1, pt2, (0,0,255), 2)

                center_point = (int(bbox[0]) + int(bbox[2])/2, int(bbox[1]) + int(bbox[3])/2)

                cv.putText(img, "str_id", topLeft, fontFace=cv.FONT_HERSHEY_COMPLEX,
                    fontScale=0.5, color=(255, 255, 255), thickness=1)
        else:
            flagTrack = False
   
            """
    #show final image
    cv.imshow("img", img)

    if cv.waitKey(1) & 0xFF == ord('q'):
        cap.release()
        cv.destroyAllWindows()
        break
