  
import subprocess
import os
import cv2 as cv
  

def executeCpp(img):
  
    # create a pipe to a child process
    data, temp = os.pipe()
    print("1")
    # write to STDIN as a byte object(convert string
    # to bytes with encoding utf8)
    os.write(temp, bytes(str(img), 'utf8'))
    os.close(temp)
    
    # store output of the program as a byte string in s
    s = subprocess.check_output("make;./subCpp", stdin = data, shell = True)
  
    # decode s to a normal string
    print(s.decode("utf-8"))


if __name__=="__main__":
    img = cv.imread("AR6.jpeg")

    executeCpp(img) 
