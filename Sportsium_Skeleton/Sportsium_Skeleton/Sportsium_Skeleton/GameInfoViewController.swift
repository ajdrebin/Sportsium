//
//  GameInfoViewController.swift
//  Sportsium_Skeleton
//
//  Created by Alina Drebin on 10/31/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    var home = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var away = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    
    var homePlayers: [Player?] = []
    var awayPlayers: [Player?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homePlayers = home.playerList  // all player objects
        awayPlayers = away.playerList
    }
    
    func makeButtons() {
//      var buttons = [UIButton]()
      var button : UIButton

      var x :CGFloat = 0
      var y :CGFloat = 400.0

      for (i, player) in homePlayers.enumerated() {
        button = UIButton()
        // x, y, width, height
        


        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width


        button.frame = CGRect(x: x, y: y, width: screenWidth, height: 100.0)
        if i % 2 == 0 {
          button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
        }
        else{
          button.backgroundColor = UIColor.white
        }

        button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

        //Allow for multi line text \n separated.
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.setTitle(player?.number, for: UIControl.State.normal)



        button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
        button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)

        button.tag = i
        
        //x = x * 2.0
        y = y + 100

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
      print(btn.titleLabel?.text)
      last_pressed = btn.titleLabel!.text!
      performSegue(withIdentifier: "PlayerInfo", sender: self)
    }

    @IBOutlet var TeamOne: UIView!
    
    // might need to change
    @IBOutlet var homeButton: UIImageView!
    @IBOutlet var camera: UIImageView!
    @IBOutlet var listTeams: UIImageView!
    @IBOutlet weak var TeamOnePlayerOne: UIView!
    @IBOutlet weak var TeamOnePlayerTwo: UIView!
    @IBOutlet weak var TeamOnePlayerThree: UIView!
    @IBOutlet weak var TeamOnePlayerFour: UIView!
    @IBOutlet weak var TeamOnePlayerFive: UIView!
    @IBOutlet weak var TeamOnePlayerSix: UIView!
    @IBOutlet weak var TeamOnePlayerSeven: UIView!
    @IBOutlet weak var TeamOnePlayerEight: UIView!
    @IBOutlet weak var TeamOnePlayerNine: UIView!
}
