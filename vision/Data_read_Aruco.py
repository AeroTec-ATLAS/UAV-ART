import cv2
import numpy as np
import cv2.aruco as aruco
import math
import matplotlib.pyplot as plt
from scipy.signal import lfilter
from scipy.signal import medfilt


data = np.loadtxt('test1.txt', dtype=float)
L=0
datafilt = []
datafiltered2 = medfilt(data, 51) #Filtered data from noise
plt.figure() #Plot all data along with the data filtered
plt.plot(data, linewidth=1, linestyle="-", c="r")
plt.plot(datafiltered2, linewidth=2, linestyle="-", c="b") 
index = 0
for i in range(1, len(data)):
    if data[i] > data[i-1]+20: #Divide data when there's a difference of 20 cm of distance
        datafilt.append(data[index:i-1])
        index = i
        L=L+1

datafilt.append(data[index:i])

n = 0
datafilt = np.array(datafilt)
fig1, ax1 = plt.subplots(1, L+1)
while n <= L:
    #plt.figure()   #Plot individual distance
    #plt.plot(datafilt[n])
    #plt.figure()  #Plot individual histogram
    #plt.hist(datafilt[n], bins = 50)
    #fig1, ax1 = plt.subplots() #Plot individual boxplot
    #ax1.set_title('Basic Plot')
    ax1[n].boxplot(datafilt[n], showmeans= True) #Plot boxplots together
    n=n+1

plt.show()
