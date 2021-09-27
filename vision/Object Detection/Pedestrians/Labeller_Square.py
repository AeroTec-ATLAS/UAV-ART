import cv2 as cv
import numpy as np
import os
import random
import progressbar as progressbar
  
frame_height = 2160
frame_width = 3840 

train_split = 0.7

widgets = [' [',
         progressbar.Timer(format= 'elapsed time: %(elapsed)s'),
         '] ',
           progressbar.Bar('*'),' (',
           progressbar.ETA(), ') ',
          ]
  
files = list(os.listdir('PDESTRE/Videos'))
files.sort()

train_file = open('train_pdestre.txt', 'w')
val_file = open('val_pdestre.txt', 'w')

def save_img(img, frame_counter, id, train_file, val_file):

    img_name = 'PDESTRE/images/' + file[:-4] + '-{}-{}.jpg'.format(frame_counter, id)

    label_file = open('PDESTRE/labels/' + file[:-4] + '-{}-{}.txt'.format(frame_counter, id), 'w')
    label_file.close()

    directory = os.getcwd()

    if(random.random() < train_split):
        train_file.write(directory + '/PDESTRE/images/' + file[:-4] + '-{}-{}.jpg\n'.format(frame_counter, id))
    else:
        val_file.write(directory + '/PDESTRE/images/' + file[:-4] + '-{}-{}.jpg\n'.format(frame_counter, id))

    cv.imwrite(img_name, img)




def save_label(line, file_name, id, test, transform):

    line = list(line.split(','))
    (frame_number, x, y, h, w) = transform(int(line[0]), float(line[2]), float(line[3]), float(line[4]), float(line[5]))

    if (test(x, y, h, w) == True):
        label_file = open('PDESTRE/labels/' + file_name + '-{}-{}.txt'.format(frame_number, id), 'a')
        object_str = "0 {} {} {} {} \n".format(x, y, w, h)
        label_file.write(object_str)
        label_file.close()



for file in files:
    print(file)

    frame_counter = 1 
    cap = cv.VideoCapture('PDESTRE/Videos/' + file)

    num_frames = int(cap.get(cv.CAP_PROP_FRAME_COUNT))
    bar = progressbar.ProgressBar(max_value = num_frames, 
                              widgets=widgets).start()
    
    while(1):
        # Read current frame
        ret,img = cap.read()
        if img is None:
            break

        bar.update(frame_counter)

        save_img(img[:, :frame_height], frame_counter, 1, train_file, val_file)
        save_img(img[:, -frame_height:], frame_counter, 2, train_file, val_file)

        frame_counter += 1


train_file.close()
val_file.close()

labels = list(os.listdir('PDESTRE/Annotations'))
labels.sort()


for label in labels:
    file_name = label[:-4]
    print(file_name)

    lines = open('PDESTRE/Annotations/' + label).read().strip().split('\n')

    for line in lines:
        left_transform = lambda frame_counter_, x_, y_, h_, w_ : (frame_counter_, x_/frame_height, y_/frame_height, h_/frame_height, w_/frame_height)
        left_test = lambda x, y, h, w: x + w <= 1 and x >= 0
        save_label(line, file_name, 1, left_test, left_transform)

        right_transform = lambda frame_counter_, x_, y_, h_, w_ : (frame_counter_, (x_ - frame_width + frame_height)/frame_height, y_/frame_height, h_/frame_height, w_/frame_height)
        right_test = lambda x, y, h, w: x + w <= 1 and x >= 0
        save_label(line, file_name, 2, right_test, right_transform)

        

