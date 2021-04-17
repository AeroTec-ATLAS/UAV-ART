/*
 * CVBoostConverter.hpp
 *
 *  Created on: Mar 20, 2014
 *      Author: Gregory Kramida
 *   Copyright: (c) 2014 Gregory Kramida
 *     License: MIT
 * 
 * Source: https://github.com/Algomorph/pyboostcvconverter/blob/master/include/pyboostcvconverter/pyboostcvconverter.hpp
 */

#ifndef CVBOOSTCONVERTER_HPP_
#define CVBOOSTCONVERTER_HPP_

#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
#include <Python.h>
#include <ndarrayobject.h>
#include <opencv2/core/core.hpp>
#include <boost/python.hpp>
#include <cstdio>

namespace pbcvt{
using namespace cv;
static PyObject* opencv_error = 0;


//===================    MACROS    =================================================================
#define ERRWRAP2(expr) \
try \
{ \
    PyAllowThreads allowThreads; \
    expr; \
} \
catch (const cv::Exception &e) \
{ \
    PyErr_SetString(opencv_error, e.what()); \
    return 0; \
}

//===================   THREADING     ==============================================================
class PyAllowThreads;

//===================   STANDALONE CONVERTER FUNCTIONS     =========================================

PyObject* fromMatToNDArray(const Mat& m);
Mat fromNDArrayToMat(PyObject* o);

} // end namespace pbcvt
#endif /* CVBOOSTCONVERTER_HPP_ */