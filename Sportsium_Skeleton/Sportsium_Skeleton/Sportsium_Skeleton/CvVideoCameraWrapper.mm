//
//  OpenCVWrapper.mm
//  OpenCV_1
//
//  Created by Anatoli on 5/25/16.
//  Copyright © 2016 Anatoli Peredera. All rights reserved.
//

#import "CvVideoCameraWrapper.h"
#import <opencv2/videoio/cap_ios.h>
#include <opencv2/imgcodecs/ios.h>


//#import "OpenCV_1-Swift.h"

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
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait]; [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    videoCamera = [[CvVideoCamera alloc] initWithParentView:iv];
    
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
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
//    std::cout<< "hello" << std::endl;
//     cv::Mat image_copy = [self convertToYellow:image];
    cv::Mat image_copy = [self convertToGreen:image];


        
}

- (cv::Mat)convertToGreen:(cv::Mat)image
{
    cout << "got here" << endl;
    cv::Mat cameraFeed = image;
    cv::Mat HSV, mask;
    cv::cvtColor(cameraFeed, HSV, CV_BGR2HSV);
    
    //green range
     cv::Scalar lower_green(0,50,50);
     cv::Scalar upper_green(70,255,255);

    //blue range
//    cv::Scalar lower_blue(110,50,50);
//    cv::Scalar upper_blue(130,255,255);
//    cv::Scalar lower_blue(0,0,150);
//    cv::Scalar upper_blue(70,70,255);
    cv::Scalar lower_blue(100,100,20);
    cv::Scalar upper_blue(130,255,255);

    //red range
    cv::Scalar lower_red(0,31,255);
    cv::Scalar upper_red(176,255,255);
//    cv::Scalar lower_red(0,0,0);
//    cv::Scalar upper_red(15,80,80);

    //white range
    cv::Scalar lower_white(0,0,0);
    cv::Scalar upper_white(0,0,255);

    cv::inRange(HSV, lower_green, upper_green, mask);
    cv::Mat res, res_bgr, res_gray;
    cv::bitwise_and(cameraFeed, cameraFeed, res, mask);
    cv::cvtColor(res, res_gray, CV_BGR2GRAY);

    cv::Mat kernel = getStructuringElement( cv::MORPH_RECT, cvSize(13,13));
    cv::Mat thresh;
    cv::threshold(res_gray, thresh, 127, 255, cv::THRESH_BINARY_INV | cv::THRESH_OTSU);
    cv::morphologyEx(thresh, thresh, cv::MORPH_CLOSE, kernel);

    cv::Mat temp;
    thresh.copyTo(temp);
    vector< vector<cv::Point> > contours;
    vector<cv::Vec4i> hierarchy;

    findContours( temp, contours, hierarchy, CV_RETR_TREE,  CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
    

    int font = cv::FONT_HERSHEY_SIMPLEX;

    cout << contours.size() << endl;
    for( size_t k = 0; k < contours.size(); k = k + 1 ) {
        cv::Rect rect = cv::boundingRect(contours[k]);
        cv::Point pt1, pt2;
        pt1.x = rect.x;
        pt1.y = rect.y;
        pt2.x = rect.x + rect.width;
        pt2.y = rect.y + rect.height;
        
        if(rect.height>=(1.5)*rect.width){
            if(rect.width>15 and rect.height>= 15){
                cv::Mat player_img = cv::Mat(cameraFeed, rect);
                cv::Mat player_hsv;
                cv::cvtColor(player_img, player_hsv, cv::COLOR_BGR2HSV);
                
                //If player has blue jersy
                cv::Mat mask1, res1;
                cv::inRange(player_hsv, lower_blue, upper_blue, mask1);
                cv::bitwise_and(player_img, player_img, res1, mask1);
                cv::cvtColor(res1, res1, cv::COLOR_BGR2GRAY);
                int nzCountBlue = cv::countNonZero(res1);
                cout << "nzCountBlue: " << nzCountBlue << endl;
                
                //If player has red jersy
                cv::Mat mask2, res2;
                cv::inRange(player_hsv, lower_red, upper_red, mask2);
                cv::bitwise_and(player_img, player_img, res2, mask2);
                cv::cvtColor(res2, res2, cv::COLOR_BGR2GRAY);
                int nzCountRed = cv::countNonZero(res2);
                cout << "nzCountRed: " << nzCountRed << endl;
                
                if(nzCountBlue >= 10){
                    cv::putText(cameraFeed, "Blue Team", pt1, font, 0.5, cv::Scalar(255,0,0));
                    cv::rectangle(cameraFeed, pt1, pt2, CV_RGB(0,0,255), 1);
                }
                if(nzCountRed >= 10){
//                    cv::putText(cameraFeed, "Red Team", pt1, font, 0.5, cv::Scalar(0,0,255));
                    cv::putText(cameraFeed, " Detection off ", pt1, cv::FONT_HERSHEY_COMPLEX_SMALL, 0.5,  cv::Scalar(0,0,255), 2 , 8 , false);
                    cout << "hit here" << endl;
                    cv::rectangle(cameraFeed, pt1, pt2, CV_RGB(255,0,0), 1);
                }
            }
        }
            
                
        // Draws the rect in the original image and show it
//        cv::rectangle(cameraFeed, pt1, pt2, CV_RGB(255,0,0), 1);
    }
//    transpose(cameraFeed, cameraFeed);
//    flip(cameraFeed, cameraFeed, 1);
    
//    cv::cvFlip(cameraFeed);
    transpose(cameraFeed, cameraFeed);
    flip(cameraFeed, cameraFeed, 0);
    return cameraFeed;
}



- (cv::Mat)convertToYellow:(cv::Mat)image
{
cv::Mat cameraFeed = image;
cv::Mat HSV, threshold;
cv::cvtColor(cameraFeed, HSV, CV_BGR2HSV);
cv::inRange(HSV, cv::Scalar(90,50,50), cv::Scalar(130,255,255), threshold);

cv::Mat erodeElement = getStructuringElement( cv::MORPH_RECT,    cvSize(3,3));
//dilate with larger element so make sure object is nicely visible
cv::Mat dilateElement = getStructuringElement(  cv::MORPH_RECT,cvSize(3,3));

erode(threshold,threshold,erodeElement);
erode(threshold,threshold,erodeElement);

dilate(threshold,threshold,dilateElement);
dilate(threshold,threshold,dilateElement);

cv::Mat temp;
threshold.copyTo(temp);
vector< vector<cv::Point> > contours;
vector<cv::Vec4i> hierarchy;

findContours( temp, contours, hierarchy, CV_RETR_EXTERNAL,  CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );

bool objectFound = false;
if (hierarchy.size() > 0) {

    for (int index = 0; index >= 0; index = hierarchy[index][0]) {

        cv::Moments moment = moments((cv::Mat)contours[index]);
        double area = moment.m00;


        if(area > 500){

            objectFound = true;

        }else objectFound = false;
    }

    //let user know you found an object
    if(objectFound ==true){

        for(int i=0; i < contours.size() ; i++)
        {
                    cv::drawContours(cameraFeed,contours,i, cv::Scalar(0,255,255,255),CV_FILLED);

        }

    }

}

return cameraFeed;

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
