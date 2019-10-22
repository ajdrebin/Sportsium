//
//  OpenCVWrapper.mm
//  OpenCV_1
//
//  Created by Anatoli on 5/25/16.
//  Copyright © 2016 Anatoli Peredera. All rights reserved.
//

#import "CvVideoCameraWrapper.h"
#import <opencv2/videoio/cap_ios.h>

#import "OpenCV_1-Swift.h"

//using namespace cv;
using namespace std;

// An extension to conform to the delegate protocol
@interface CvVideoCameraWrapper () <CvVideoCameraDelegate>
@end

@implementation CvVideoCameraWrapper
{
    // A member variable holding the wrapped CvVideoCamera
    CvVideoCamera * videoCamera;
}

-(id)initWithImageView:(UIImageView*)iv
{
    videoCamera = [[CvVideoCamera alloc] initWithParentView:iv];
    
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    videoCamera.defaultFPS = 30;
    videoCamera.grayscaleMode = NO;
    
    videoCamera.delegate = self;
    
    return self;
}

// The only method of the CvVideoCameraDelegate protocol, visible only
// to C++ (including Objective-C++) code.
#ifdef __cplusplus 
- (void)processImage:(cv::Mat&)image
{
    // Do some OpenCV stuff with the image
//    Mat image_copy;
//    cvtColor(image, image_copy, CV_BGRA2BGR);
    
    // invert image
//    bitwise_not(image_copy, image_copy);
//    cvtColor(image_copy, image, CV_BGR2BGRA);
//    cvtColor(image_copy, image, CV_BGR2HSV);
    cv::Mat hsvImage;
    cv::cvtColor(image , hsvImage, CV_BGR2HSV);
    
    //green range
     cv::Scalar lower_green(0,50,50);
     cv::Scalar upper_green(70,255,255);

    //blue range
    cv::Scalar lower_blue(110,50,50);
    cv::Scalar upper_blue(130,255,255);
    
    //red range
    cv::Scalar lower_red(0,31,255);
    cv::Scalar upper_red(176,255,255);
    
    //white range
    cv::Scalar lower_white(0,0,0);
    cv::Scalar upper_white(0,0,255);
    
//    Define a mask ranging from lower to upper
    cv::Mat mask;
    cv::inRange(hsvImage, lower_green, lower_white, mask);
    cv::Mat res(image.size(), image.type());
    cv::bitwise_and(image, image, res, mask);
    
    cv::Mat res_bgr(image.size(), image.type());
    cv::cvtColor(res, res_bgr, cv::COLOR_BGRA2BGR);

    cv::Mat res_gray;
    cv::cvtColor(res, res_gray, cv::COLOR_BGRA2GRAY);
    
//    cv::Mat kernel = cv::Mat::ones(10, 10, CV_8UC1);
//    double thresh = threshold(res_gray, mask, 127, 255, cv::THRESH_BINARY_INV | cv::THRESH_OTSU);
//    cv::Mat thresh_out;
//    cv::morphologyEx(thresh, thresh_out, cv::MORPH_CLOSE, kernel);
//
//    std::vector<std::vector<Point> > contours;
//    cv::Mat heirarchy;
//    cv::findContours(thresh_out, contours, heirarchy, cv::RETR_TREE, cv::CHAIN_APPROX_SIMPLE);
    
    cv::Mat thresholded;
    cv::inRange(res_gray, cv::Scalar(40,40,40), cv::Scalar(160,160,160), thresholded);

    cv::Mat kernel = cv::Mat::ones(13, 13, CV_64FC1);
    cv::Mat opening;
    cv::morphologyEx(thresholded, opening, cv::MORPH_CLOSE, kernel);

    vector<vector<cv::Point>> contours;
    cv::findContours(opening, contours, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE);
    
    int prev = 0;
    int font = cv::FONT_HERSHEY_SIMPLEX;
//     contours.resize(contours0.size());
    cout << contours.size() << endl;
    for( size_t k = 0; k < contours.size(); k = k + 1 ) {
        cv::Rect rect = cv::boundingRect(contours[k]);
        cout << rect << endl;
    }
        
}
#endif

-(void)startCamera
{
    [videoCamera start];
}

-(void)stopCamera
{
    [videoCamera stop];
}
@end
