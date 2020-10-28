import cv2
import numpy as np

img1 = cv2.imread('select image 1')
img2 = cv2.imread('select image 2')

blur1 = cv2.GaussianBlur(img1,(5,5),0)
blur2 = cv2.GaussianBlur(img2,(5,5),0)
#
edges1 = cv2.Canny(img1,100,200)
edges2 = cv2.Canny(img2,100,200)

sift = cv2.xfeatures2d.SIFT_create()

kp1, d1 = sift.detectAndCompute(img1,None)

kp2, d2 = sift.detectAndCompute(img2,None)

########## BF
###############
# bf = cv2.BFMatcher()
# # matches = bf.match(d1,d2)
# # matches = sorted(matches, key = lambda x:x.distance)
# matches = bf.knnMatch(d1,d2, k=2)
#
# good = []
# dist = []
# for m,n in matches:
#     if m.distance < 0.7*n.distance:
#         good.append(m)
#         dist.append(m.distance)
#         texto = '  BF'
##################
# # print (dist)

########## FLANN
matcher = cv2.DescriptorMatcher_create(cv2.DescriptorMatcher_FLANNBASED)

knn_matches = matcher.knnMatch(d1, d2, 2)
ratio_thresh = 0.3
good = []
dist = []
for m,n in knn_matches:
    if m.distance < ratio_thresh * n.distance:
        good.append(m)
        # print(m.distance)
        dist.append(m.distance)
        texto = '  FLANN'

# print(len(kp1))
u = len(kp1)
poskp1 = []
x=0

while x < u:
    # print (kp1[x].pt)
    poskp1.append([kp1[x].pt])
    x=x+1


######-- MÉDIA DA DISTÂNCIA DOS matches

i=0
x=0
u = 1

while i <= (len(dist)-1):
    x = dist[i] + x
    media = x/u
    i = i+1
    u = u+1

print (str(media) + texto)

#-- Draw matches
img3 = cv2.drawMatches(img1,kp1,img2,kp2,good[:40],None,flags=2)

width = int(img3.shape[1] * 0.3)
height = int(img3.shape[0] * 0.3)

cv2.namedWindow('img3', cv2.WINDOW_GUI_NORMAL)
cv2.imshow('img3',img3)
cv2.imwrite( 'image3', img3);

img1 = cv2.drawKeypoints(img1,kp1,cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
img2 = cv2.drawKeypoints(img2,kp2,cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
width1 = int(img1.shape[1] * 0.3)
height1 = int(img1.shape[0] * 0.3)

img1 = cv2.resize(img1, (width1, height1))
img2 = cv2.resize(img2, (width1, height1))

edges1 = cv2.resize(edges1, (width1, height1))
edges2 = cv2.resize(edges2, (width1, height1))


cv2.imshow("Image1", img1)
cv2.imshow("Image4", img2)
cv2.imshow("Image2", edges1)
cv2.imshow("Image3", edges2)

if cv2.waitKey(33) == ord('p'):
    cv2.destroyAllWindows
