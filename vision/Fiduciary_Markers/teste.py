import cv2 as cv
import numpy as np
import sys

img = cv.imread("AR6.jpeg")

cap = cv.VideoCapture("/home/vasco/Desktop/CODE/UAV_Fiducial_Markers/New_Images/C_fast_short.MOV")
video = []
while(True):
    sucess, img = cap.read()
    if not(sucess):
        break
    video.append(img)

my_string = ""

for i in video:
    my_string += ('{} ').format(i)


sys.stdout.buffer.write(bytes(my_string, 'utf8'))

print("end")