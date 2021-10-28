######## A simple cmakelists.txt file for OpenCV() #############
cmake_minimum_required(VERSION 2.8)
PROJECT(main3)

FIND_PACKAGE( OpenCV REQUIRED )
INCLUDE_DIRECTORIES( ${OpenCV_INCLUDE_DIRS} )

ADD_EXECUTABLE(main3 main3.cpp)
TARGET_LINK_LIBRARIES (main3 ${OpenCV_LIBS})
########### end ####################################
