//
//  ListTeamsViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/2/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation

class ListTeamsViewController: UIViewController {
    
    let keysList = Array(teamsDict.keys)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(teamsDict.keys)
        makeButtons()
        }
    
        func makeButtons() {
    //      var buttons = [UIButton]()
          var button : UIButton

          var x :CGFloat = 0
          var y :CGFloat = 25

            for (i, teamName) in keysList.enumerated() {
            if i > 10 {
                break
            }
                
            button = UIButton()
            button.tag = i
            // x, y, width, height
            


            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width


            button.frame = CGRect(x: x, y: y, width: screenWidth, height: 75)
            if i % 2 == 0 {
              button.backgroundColor = UIColor.white
            }
            else{
              button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
            }
                
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -70, bottom: 0, right: 70)
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: -45)

            button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

            //Allow for multi line text \n separated.
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
                button.setTitle("\t" + teamsDict[teamName]!.teamName, for: UIControl.State.normal)
                
                
                var teamLogo:UIImage = UIImage(named:teamName)!
                button.setImage(teamLogo, for: UIControl.State.normal)

            button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
            button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)

            button.tag = i
            
            //x = x * 2.0
            y = y + 75
            
            button.titleLabel?.font = .systemFont(ofSize: 15)
            
            mainView.addSubview(button)

          }
            
        }
    
        @objc func pressBtn(sender: UIButton!) {
          let btn: UIButton = sender
          btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        }
        
        @objc func releaseBtn(sender: UIButton!) {
          let btn: UIButton = sender
          btn.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
        }
        
        var last_pressed = 0
        @objc func buttonAction(sender: UIButton!) {
          let btn: UIButton = sender
    //      print(btn.titleLabel?.text)
          last_pressed = btn.tag
            print(btn.tag)
          performSegue(withIdentifier: "Team", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Team"){
            let displayVC = segue.destination as! TeamInfoViewController
            displayVC.home = teamsDict[keysList[last_pressed]]!
            displayVC.away_team_name = away
        }
    }
        
    
    @IBOutlet var mainView: UIView!
    weak var home: UIImageView!
        weak var camera: UIImageView!
        weak var listTeams: UIImageView!
}
