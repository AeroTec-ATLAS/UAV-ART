######## A simple cmakelists.txt file for OpenCV() #############  
cmake_minimum_required(VERSION 2.8)                            
PROJECT(subCpp)                                         

FIND_PACKAGE( OpenCV REQUIRED )                              
INCLUDE_DIRECTORIES( ${OpenCV_INCLUDE_DIRS} )

ADD_EXECUTABLE(subCpp subCpp.cpp)                         
TARGET_LINK_LIBRARIES (subCpp ${OpenCV_LIBS})         
########### end ####################################  