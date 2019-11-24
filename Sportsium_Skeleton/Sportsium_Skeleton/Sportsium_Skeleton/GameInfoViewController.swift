//
//  GameInfoViewController.swift
//  Sportsium_Skeleton
//
//  Created by Alina Drebin on 10/31/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    var home: TeamInfo?
    var away: TeamInfo?
    
    var homePlayers:[Player] = []
    var awayPlayers:[Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homePlayers = home!.playerList  // all player objects
        awayPlayers = away!.playerList
        print(homePlayers)
        makeButtons()
    }
    
    func makeButtons() {
//      var buttons = [UIButton]()
      var button : UIButton

      var x :CGFloat = 0
      var y :CGFloat = 250.0
        
        var teamLogoImageView:UIImageView = UIImageView()
        var teamLogo1:UIImage = UIImage(named:"houston_dash")!
        var teamLogoTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTeam))
//        teamLogoTap.delegate = self as? UIGestureRecognizerDelegate
        teamLogoImageView.addGestureRecognizer(teamLogoTap)
        teamLogoImageView.isUserInteractionEnabled = true
        
        teamLogoImageView.frame = CGRect(x: 75, y: 125, width: 75, height: 75)
        teamLogoImageView.contentMode = UIView.ContentMode.scaleAspectFit;
        teamLogoImageView.image = teamLogo1
        mainView.addSubview(teamLogoImageView)

      for (i, playerInd) in homePlayers.enumerated() {
        if i > 10 {
            break
        }
        print(playerInd.firstName)
        button = UIButton()
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
        button.setTitle(playerInd.number + "\t\t" + playerInd.firstName + "\n" + playerInd.position, for: UIControl.State.normal)


        button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
        button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)

        button.tag = i
        
        //x = x * 2.0
        y = y + 40
        
        button.titleLabel?.font = .systemFont(ofSize: 11)
        
        mainView.addSubview(button)

      }
        
        y = 250
        
        for (i, playerInd) in awayPlayers.enumerated() {
          if i > 10 {
              break
          }
          print(playerInd.firstName)
          button = UIButton()
          // x, y, width, height
          


          let screenSize = UIScreen.main.bounds
          let screenWidth = screenSize.width


          button.frame = CGRect(x: screenWidth/2, y: y, width: screenWidth/2, height: 40.0)
          if i % 2 == 0 {
            button.backgroundColor = UIColor.white
          }
          else{
            button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
          }

          button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

          //Allow for multi line text \n separated.
          button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
          button.setTitle(playerInd.number + "\t\t" + playerInd.firstName + "\n" + playerInd.position, for: UIControl.State.normal)


          button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
          button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
          button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
          button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)

          button.tag = i
          
          //x = x * 2.0
          y = y + 40
          
          button.titleLabel?.font = .systemFont(ofSize: 11)
          
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
    
    var last_pressed = "none"
    @objc func buttonAction(sender: UIButton!) {
      let btn: UIButton = sender
//      print(btn.titleLabel?.text)
      last_pressed = btn.titleLabel!.text!
      performSegue(withIdentifier: "PlayerInfo", sender: self)
    }
    
    @objc func tappedTeam(sender:AnyObject) {
        print("yoooooo")
        performSegue(withIdentifier: "Team", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PlayerInfo"){
                let displayVC = segue.destination as! PlayerInfoViewController
                displayVC.button_text = "yeeeer"
                
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "PlayerInfo"){
//                let displayVC = segue.destination as! PlayerInfoViewController
//                displayVC.button_text = last_pressed
//        }
//    }
    
    // might need to change
    
    @IBOutlet var mainView: UIView!
    
    
}
