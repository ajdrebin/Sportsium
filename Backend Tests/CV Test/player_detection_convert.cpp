#include <opencv2/opencv.hpp>
// #include "opencv-4.1.1/opencv.hpp"
#include <iostream>
 
using namespace std;
using namespace cv;
 
int main(){
 
    cv::Mat image = imread("soccer.jpg", CV_LOAD_IMAGE_COLOR);
    Mat img_thresh;
    threshold(img, img_thresh, 0, 255, CV_THRESH_BINARY);

    vector<vector<Point> > contours;
    vector<Vec4i> hierarchy;
    cv::findContours(img_thresh, contours, hierarchy, RetrievalModes::RETR_TREE, ContourApproximationModes::CHAIN_APPROX_SIMPLE);

    RNG rng(12345);
    Mat drawing = Mat::zeros(img_thresh.size(), CV_8UC3);
    for (int i = 0; i< contours.size(); i++)
    {
        Scalar color = Scalar(rng.uniform(0, 255), rng.uniform(0, 255), rng.uniform(0, 255));
        drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, Point());
    }
    imshow("drawing", drawing);
    waitKey();
//     cv::Mat hsvImage;
//     cv::cvtColor(image , hsvImage, CV_BGR2HSV);
    
//     //green range
//      cv::Scalar lower_green(0,50,50);
//      cv::Scalar upper_green(70,255,255);

//     //blue range
//     cv::Scalar lower_blue(110,50,50);
//     cv::Scalar upper_blue(130,255,255);
    
//     //red range
//     cv::Scalar lower_red(0,31,255);
//     cv::Scalar upper_red(176,255,255);
    
//     //white range
//     cv::Scalar lower_white(0,0,0);
//     cv::Scalar upper_white(0,0,255);
    
// //    Define a mask ranging from lower to upper
//     cv::Mat mask;
//     cv::inRange(hsvImage, lower_green, lower_white, mask);
//     cv::Mat res(image.size(), image.type());
//     cv::bitwise_and(image, image, res, mask);
    
//     cv::Mat res_bgr(image.size(), image.type());
//     cv::cvtColor(res, res_bgr, cv::COLOR_BGRA2BGR);

//     cv::Mat res_gray;
//     cv::cvtColor(res, res_gray, cv::COLOR_BGRA2GRAY);
    
// //    cv::Mat kernel = cv::Mat::ones(10, 10, CV_8UC1);
// //    double thresh = threshold(res_gray, mask, 127, 255, cv::THRESH_BINARY_INV | cv::THRESH_OTSU);
// //    cv::Mat thresh_out;
// //    cv::morphologyEx(thresh, thresh_out, cv::MORPH_CLOSE, kernel);
// //
// //    std::vector<std::vector<Point> > contours;
// //    cv::Mat heirarchy;
// //    cv::findContours(thresh_out, contours, heirarchy, cv::RETR_TREE, cv::CHAIN_APPROX_SIMPLE);
    
//     cv::Mat thresholded;
//     cv::inRange(res_gray, cv::Scalar(40,40,40), cv::Scalar(160,160,160), thresholded);

//     cv::Mat kernel = cv::Mat::ones(13, 13, CV_64FC1);
//     cv::Mat opening;
//     cv::morphologyEx(thresholded, opening, cv::MORPH_CLOSE, kernel);

//     vector<vector<cv::Point>> contours;
//     cv::Mat hierarchy;
//     cv::findContours(opening, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE);
// //    cv::findContours(opening, contours, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE);
    
//     int prev = 0;
//     int font = cv::FONT_HERSHEY_SIMPLEX;
// //     contours.resize(contours0.size());
//     cout << contours.size() << endl;
//     for( size_t k = 0; k < contours.size(); k = k + 1 ) {
//         cv::Rect rect = cv::boundingRect(contours[k]);
//         cout << rect << endl;
//     } 
  
 
  return 0;
}