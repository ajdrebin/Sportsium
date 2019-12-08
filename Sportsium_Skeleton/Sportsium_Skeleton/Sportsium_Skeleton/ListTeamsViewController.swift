//
//  ListTeamsViewController.swift
//  Sportsium
//
//  Created by Jess Cheng on 11/2/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation
import UIKit

class ListTeamsViewController: UIViewController {
    
    let keysList = Array(teamsDict.keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(teamsDict.keys)
        print(league)
        makeButtons()
        mainView.addSubview(scrollView)
    }
    
    func makeButtons() {
        
        var teamList:UILabel = UILabel()
        teamList.text = "All Teams"
        teamList.font = .systemFont(ofSize: 18)
        teamList.frame = CGRect(x: 150, y: 65, width: 200, height: 30)
        teamList.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
        mainView.addSubview(teamList)
        
         var y :CGFloat = 0
        scrollView.contentSize = (CGSize(width:UIScreen.main.bounds.width, height: CGFloat(75 * (keysList.count + 1) )))
        
        for (i, teamName) in keysList.enumerated() {
            
            
            var button : UIButton
            
            var x :CGFloat = 0
            
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            
            var teamLabel:UILabel = UILabel()
            teamLabel.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 75)
            
            var teamLabelTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTeam))
            teamLabelTap.name = String(i)
            teamLabel.addGestureRecognizer(teamLabelTap)
            teamLabel.isUserInteractionEnabled = true
            
            if i % 2 == 0 {
                teamLabel.backgroundColor = UIColor.white
            }
            else{
                teamLabel.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
            }
            
            scrollView.addSubview(teamLabel)
            
            var teamImage:UIImageView = UIImageView()
            teamImage.frame = CGRect(x: 85, y: y, width: 40, height: 75)
            teamImage.contentMode = UIView.ContentMode.scaleAspectFit;
            var teamLogo:UIImage = UIImage(named:keysList[i])!
            teamImage.image = teamLogo
            scrollView.addSubview(teamImage)
            var teamName:UILabel = UILabel()
            teamName.text = keysList[i]
            teamName.adjustsFontSizeToFitWidth = true
            teamName.font = .systemFont(ofSize: 16)
            teamName.frame = CGRect(x: 160, y: y, width: 200, height: 75)
            teamName.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            scrollView.addSubview(teamName)
            y = y + 75

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
    
    @objc func tapTeam(sender:AnyObject) {
        var sender = sender
        //      print(btn.titleLabel?.text)
        last_pressed = Int(sender.name)!
        performSegue(withIdentifier: "Team", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Team"){
            let displayVC = segue.destination as! TeamInfoViewController
            displayVC.team_obj = teamsDict[keysList[Int(last_pressed)]]!
            displayVC.away_team_name = away
            displayVC.prev_page = "ListTeams"
            
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    weak var home: UIImageView!
    weak var camera: UIImageView!
    weak var listTeams: UIImageView!
}
