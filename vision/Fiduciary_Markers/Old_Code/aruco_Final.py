import cv2
import numpy as np
import cv2.aruco as aruco
import math
import matplotlib.pyplot as plt



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





id_to_find = 1
marker_size = 11 #cm

data = []
Save = False

calib_path = 'markers/'
camera_matrix = np.loadtxt(calib_path+'Camera_Matrix_iPhone.txt', delimiter =',')
camera_distortion = np.loadtxt(calib_path+'Camera_Distortion_iPhone.txt', delimiter =',')

DICTNAME = aruco.DICT_4X4_50 #REPLACE HERE
aruco_dict = aruco.Dictionary_get(DICTNAME)
parameters = aruco.DetectorParameters_create()

R_Flip = np.zeros((3,3), dtype = np.float32)
R_Flip[0,0] = 1.0
R_Flip[1,1] = -1.0
R_Flip[2,2] = -1.0

font = cv2.FONT_HERSHEY_SIMPLEX
cap = cv2.VideoCapture("C:/totalcmd/IST/UAV-ART/markers/New_Images/AR_video_fast.mp4")

scale_percent = 150
scale_camera = scale_percent / 100
camera_matrix[0][0] = camera_matrix[0][0] * scale_camera
camera_matrix[0][2] = camera_matrix[0][2] * scale_camera
camera_matrix[1][1] = camera_matrix[1][1] * scale_camera
camera_matrix[1][2] = camera_matrix[1][2] * scale_camera
while True:
    sucess, frame = cap.read()
    if not(sucess):
        break
  
    
    width = int(frame.shape[1] * scale_percent / 100)
    height = int(frame.shape[0] * scale_percent / 100)
    dim = (width, height)
    
    frame = cv2.resize(frame, dim)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    corners, ids, rejected = aruco.detectMarkers(image=gray, dictionary = aruco_dict, parameters = parameters)


    if len(corners) > 0:
        print("HELLO")
        ret = aruco.estimatePoseSingleMarkers(corners, marker_size, camera_matrix, camera_distortion )

        
        rvec, tvec = ret[0][0,0,:], ret[1][0,0,:] #Rodrigues rotation vector 

        marker_distance = np.linalg.norm(tvec)
        R_ct = np.matrix(cv2.Rodrigues(rvec)[0]) # rotation matrix of camera wrt marker.
        #print(R_ct)
        R_tc = R_ct.T # rotation matrix of marker wrt camera
        roll_marker, pitch_marker, yaw_marker = rotationMatrixToEulerAngles(R_Flip*R_tc)
        aruco.drawDetectedMarkers(frame, corners)
        
        aruco.drawAxis(frame, camera_matrix, camera_distortion, rvec, tvec, 10)
        str_position = "Marker Position: x = %4.0f y = %4.0f z = %4.0f"%(tvec[0], tvec[1], tvec[2])
        cv2.putText(frame, str_position, (0, 100), font, 0.5, (255,0,0), 2, cv2.LINE_AA)

        str_distance = "Marker Distance: d = %4.0f"%(marker_distance)
        cv2.putText(frame, str_distance, (0, 150), font, 0.5, (255,0,0), 2, cv2.LINE_AA)

        str_attitude = "Marker Attitude r=%4.0f p=%4.0f y=%4.0f"%(math.degrees(roll_marker),math.degrees(pitch_marker),math.degrees(yaw_marker))
        cv2.putText(frame, str_attitude, (0, 200), font, 0.5, (255,0,0), 2, cv2.LINE_AA)

        data.append(marker_distance)

        if cv2.waitKey(1) & 0xFF == ord('p'): #Pause
            cv2.waitKey(-1)

    cv2.imshow('Frame', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        cap.release()
        cv2.destroyAllWindows() 
        break

if data:
    plt.plot(data)
    plt.show()
    if Save:
        np.savetxt('Results_M3.txt', data, fmt='%f')









