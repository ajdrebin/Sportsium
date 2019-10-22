//
//  OpenCVWrapper.m
//  ML-test
//
//  Created by Alina Drebin on 10/20/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
using namespace std;
using namespace cv;

@interface OpenCVWrapper ()

@end

@implementation OpenCVWrapper
+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}
- (void) isThisWorking {
     cout << "Hey" << endl;
    
     //cap.open(0) for camera
    cv::VideoCapture cap(0);
    if(!cap.isOpened()) NSLog(@"Could not open file");
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
