#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include "opencv2/opencv.hpp"
using namespace cv;
#include <cstdio>
#include <thread>

#include <sys/stat.h>
#include <chrono>
using namespace std;

union pipe
{
    uint8_t image[1440] [1920] [3];
    uint8_t data [1440 * 1920 * 3];
} raw;

int main(){
    // Reads in the raw data
    while(true){
        fread(&raw.image, 1, sizeof(raw.data), stdin);
        Mat image;
        // Rebuild raw data to cv::Mat
        image = Mat(1440, 1920, CV_8UC3, *raw.image);
        imshow("window", image);
        cout << "1";
       if (cv::waitKey(0) == 27)
		{
			std::cout << "Esc key is pressed by user. Stopping the video\n";
			break;
		}
    }
    cout << "helooooooooooooooooooo";

    return 0;
}