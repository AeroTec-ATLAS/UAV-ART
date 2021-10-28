This folder contains all the necessary code to perform the detection of our own Fiduciary Markers, the Marker C.

To run Python version:

```
$ python3 markerC_detector.py
```



To run C++ version:

```
$ cmake .
$ make
$ ./markerC_detector
```

To run the pipeline Python-C++:

```
$ python3 markerC_pipe.py"
//and the following lines on another terminal:
$ cmake .
$ make
$ ./markerC_pipe
```

Just remember that in order to run the cmake you have to make sure that the CMakeLists.txt has the necessary paths, either the C++ version or the Pipe one.
