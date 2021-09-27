import cv2 as cv
import numpy as np
import os

def make_Detection(img):

    (H, W) = img.shape[:2]

    blob = cv.dnn.blobFromImage(img, 1/255.0, (frame_size, frame_size), swapRB=True, crop=False)

    net.setInput(blob)
    outputs = net.forward(ln)
    
    boxes = []
    confidences = []
    classIDs = []

    for output in np.vstack(outputs):
        scores = output[5:]
        classID = np.argmax(scores)
        if classes[classID] != 'person':
            continue
        confidence = scores[classID]
        if confidence > confidenceT:
            x, y, w, h = output[:4] * np.array([W, H, W, H])
            p0 = int(x - w//2), int(y - h//2)
            p1 = int(x + w//2), int(y + h//2)
            boxes.append([*p0, int(w), int(h)])
            confidences.append(float(confidence))
            classIDs.append(classID)
        

    indices = cv.dnn.NMSBoxes(boxes, confidences, confidenceT, confidenceT-0.1)


    if len(indices) > 0:
        for i in indices.flatten():
            
            (x, y) = (boxes[i][0], boxes[i][1])
            (w, h) = (boxes[i][2], boxes[i][3])
            
            cv.rectangle(img, (x, y), (x + w, y + h), (255,255,255), 2)
            text = "{}: {:.4f}".format(classes[classIDs[i]],
                confidences[i])
            cv.putText(img, text, (x, y - 5),
                cv.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255), 2)



frame_size = 320
confidenceT = 0.5

classes = open('coco.names').read().strip().split('\n')

net = cv.dnn.readNetFromDarknet('yolov3.cfg', 'yolov3.weights')
#net = cv.dnn.readNetFromDarknet('yolov3-tiny.cfg', 'yolov3-tiny.weights')

net.setPreferableBackend(cv.dnn.DNN_BACKEND_OPENCV)
ln = net.getLayerNames()
ln = [ln[i[0] - 1] for i in net.getUnconnectedOutLayers()]

files = list(os.listdir('PDESTRE/Videos'))
files.sort()


for file in files:
    print(file)

    cap = cv.VideoCapture('PDESTRE/Videos/' + file)

    while(1):
        # Read current frame
        ret,img = cap.read()
        if img is None:
            break

        make_Detection(img)

        cv.imshow('Image', cv.resize(img, (1720, 980)))
        cv.waitKey(1)
   



