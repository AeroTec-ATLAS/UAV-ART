import os

os.chdir('C://totalcmd//IST//UAV-ART//markers//camera_calibration-master-2//aruco_data_3')


count = 1
for i in os.listdir():
    print(i)

    print(count)
    f_name, f_ext = os.path.splitext(i)

    f_name = str(count)

    new_name = "{}{}".format(f_name, f_ext)

    os.rename(i, new_name)
    count = count + 1

    


print(i)