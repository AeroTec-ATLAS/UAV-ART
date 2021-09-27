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

for file in files:

    frame_counter = 1 
    cap = cv.VideoCapture('PDESTRE/Videos/' + file)

    num_frames = int(cap.get(cv.CAP_PROP_FRAME_COUNT))
    bar = progressbar.ProgressBar(max_value = num_frames, 
                              widgets=widgets).start()
    
    while(1):
        #print(frame_counter)
        # Read current frame
        ret,img = cap.read()
        if img is None:
            break

        bar.update(frame_counter)
        
        img_name = 'PDESTRE/images/' + file[:-4] + '-{}.jpg'.format(frame_counter)

        label_file = open('PDESTRE/labels/' + file[:-4] + '-{}.txt'.format(frame_counter), 'w')
        label_file.close()
        
        directory = os.getcwd()

        if(random.random() < train_split):
            train_file.write(directory + '/PDESTRE/images/' + file[:-4] + '-{}.jpg\n'.format(frame_counter))
        else:
            val_file.write(directory + '/PDESTRE/images/' + file[:-4] + '-{}.jpg\n'.format(frame_counter))

        cv.imwrite(img_name, img)
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

        line = list(line.split(','))
        frame_number, x, y, h, w = int(line[0]), float(line[2])/frame_width, float(line[3])/frame_height, float(line[4])/frame_height, float(line[5])/frame_width

        label_file = open('PDESTRE/labels/' + file_name + '-{}.txt'.format(frame_number), 'a')
        object_str = "0 {} {} {} {} \n".format(x, y, w, h)
        label_file.write(object_str)
        label_file.close()


