//
//  ListTeamsViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/2/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation

class ListTeamsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        }
    
        func makeButtons() {
    //      var buttons = [UIButton]()
          var button : UIButton

          var x :CGFloat = 0
          var y :CGFloat = 250.0

            for (i, teamName) in teamsDict.keys.enumerated() {
            if i > 10 {
                break
            }
                
            button = UIButton()
            button.tag = i
            // x, y, width, height
            


            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width


            button.frame = CGRect(x: x, y: y, width: screenWidth/2, height: 40.0)
            if i % 2 == 0 {
              button.backgroundColor = UIColor.white
            }
            else{
              button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
            }

            button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

            //Allow for multi line text \n separated.
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
                button.setTitle(teamsDict[teamName]?.teamName, for: UIControl.State.normal)


//            button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
//            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//            button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
//            button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)

            button.tag = i
            
            //x = x * 2.0
            y = y + 40
            
            button.titleLabel?.font = .systemFont(ofSize: 11)
            
//            mainView.addSubview(button)

          }
            
        }
        
    
        weak var home: UIImageView!
        weak var camera: UIImageView!
        weak var listTeams: UIImageView!
}
