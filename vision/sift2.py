import cv2
import numpy as np

img1 = cv2.imread('/Users/arthurlago/Documents/UAV/CV/jpg/112800.jpg')
img2 = cv2.imread('/Users/arthurlago/Documents/UAV/CV/jpg/112801.jpg')

blur1 = cv2.GaussianBlur(img1,(5,5),0)
blur2 = cv2.GaussianBlur(img2,(5,5),0)
#
edges1 = cv2.Canny(img1,100,200)
edges2 = cv2.Canny(img2,100,200)

# grayimg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
#
#
# ret1,th1 = cv2.threshold(grayimg1,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)
#
# grayimg2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
# ret2,th2 = cv2.threshold(grayimg2,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)

# th1 = img1
# th2 = img2
#th1 = cv2.adaptiveThreshold(grayimg,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,11,2)

sift = cv2.xfeatures2d.SIFT_create()

kp1, d1 = sift.detectAndCompute(img1,None)

kp2, d2 = sift.detectAndCompute(img2,None)

# listaedges1brancas = []
i = 0

# while i < edges1.shape[1]:
#     x=0
#     while x < edges1.shape[0]:
#         r = edges1[x, i]
#         if (r==255):
#             listaedges1brancas.append([x, i])
#         # print(r)
#         x = x+1
#     i = i+1





# print(listaedges1brancas)

# kp1, d1 = sift.detectAndCompute(th1,None)
# kp2, d2 = sift.detectAndCompute(th2,None)

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


##################-- Filter matches using the Lowe's ratio test

matcher = cv2.DescriptorMatcher_create(cv2.DescriptorMatcher_FLANNBASED)

knn_matches = matcher.knnMatch(d1, d2, 2)
ratio_thresh = 0.5
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


# print(poskp1)

# x = 0
# while x < len(poskp1):

# for kp in kp1:
#     for match in good:
#         print(kp1[match.trainIdx].pt)

######-- MÉDIA DA DISTÂNCIA DOS matches

i=0
x=0
u = 1

while i <= (len(dist)-1):
    x = dist[i] + x
    media = x/u
    i = i+1
    u = u+1
    # print (i)

print (str(media) + texto)

#-- Draw matches
# img3 = cv2.drawMatchesKnn(img1,kp1,img2,kp2,good,flags=2)
img3 = cv2.drawMatches(img1,kp1,img2,kp2,good,None,flags=2)

# plt.imshow(img3),plt.show()
width = int(img3.shape[1] * 0.3)
height = int(img3.shape[0] * 0.3)
img3 = cv2.resize(img3, (width, height))
cv2.imshow('img3',img3)
#
img1 = cv2.drawKeypoints(img1,kp1,cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
img2 = cv2.drawKeypoints(img2,kp2,cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
width1 = int(img1.shape[1] * 0.3)
height1 = int(img1.shape[0] * 0.3)
# #
img1 = cv2.resize(img1, (width1, height1))
img2 = cv2.resize(img2, (width1, height1))
# #
# # width2 = int(img2.shape[1] * 0.4)
# # height2= int(img2.shape[0] * 0.4)
edges1 = cv2.resize(edges1, (width1, height1))
edges2 = cv2.resize(edges2, (width1, height1))

# th1 = cv2.resize(th1, (width1, height1))
# th2 = cv2.resize(th2, (width1, height1))
# #
cv2.imshow("Image1", img1)
cv2.imshow("Image4", img2)
cv2.imshow("Image2", edges1)
cv2.imshow("Image3", edges2)
# cv2.imshow("Image3", th1)
# cv2.imshow("Image2", th2)
cv2.waitKey(0)
cv2.destroyAllWindows
