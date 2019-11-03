// #include <opencv2/opencv.hpp>
// #include "opencv-4.1.1/opencv.hpp"
#include <iostream>
#include <string>
 
using namespace std;
//using namespace cv;


struct team_kit_info {
    char team_name[20];
    int home[3];
    int away[3];
};

struct teams {
    team_kit_info teams[9];
};



int main() {

    cout << "hello"<< endl;
    teams nwsl_teams;
    
    team_kit_info temp;
    strcpy(temp.team_name, "Red Stars");



    nwsl_teams.teams[0] = 



}

// cv::Scalar lower_home(0,50,50);
// cv::Scalar upper_home(70,255,255);