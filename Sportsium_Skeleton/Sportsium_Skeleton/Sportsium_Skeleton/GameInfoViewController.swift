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
    
//    let playerKeys = teamInfo.players.keys // player numbers: "23", "3"

    
     struct Teams: Codable {
         let orlandoPride: TeamInfo
         let skyBlue: TeamInfo
         let houstonDash: TeamInfo
         let washingtonSpirit: TeamInfo
         let northCarolinaCourage: TeamInfo
         let reign: TeamInfo
         let portlandThorns: TeamInfo
         let chicagoRedStars: TeamInfo
         let utahRoyals: TeamInfo

         enum CodingKeys: String, CodingKey {
            case orlandoPride = "orlando_pride"
            case skyBlue = "sky_blue"
            case houstonDash = "houston_dash"
            case washingtonSpirit = "washington_spirit"
            case northCarolinaCourage = "north_carolina_courage"
            case reign
            case portlandThorns = "portland_thorns"
            case chicagoRedStars = "chicago_red_stars"
            case utahRoyals = "utah_royals"
        }
    }
    
    struct TeamInfo: Codable {
        let cityLocation: String
        let league: String
        let dateFounded: String
        let instagram: String
        let currentWins: String
        let twitter: String
        let snapchat: String
        let currentTies: String
        let currentLosses: String
        let fb: String
        let headCoach: String
        let stadium: String
        let playerList: [Player]

        enum CodingKeys: String, CodingKey {
            case cityLocation = "city_location"
            case league
            case dateFounded = "date_founded"
            case instagram
            case currentWins = "current_wins"
            case twitter, snapchat
            case currentTies = "current_ties"
            case currentLosses = "current_losses"
            case fb
            case headCoach = "head_coach"
            case stadium
            case playerList = "player_list"
        }
    }
    
    struct Player: Codable {
        let firstName: String
        let lastName: String
        let instagram: String
        let hometown: String
        let twitter: String
        let number: String
        let snapchat: String
        let height: String
        let fb: String
        let DOB: String
        let country: String
        let playerId: Int
        let position: String

        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case instagram, hometown, twitter, number, snapchat, height, fb
            case DOB = "date_of_birth"
            case country
            case playerId = "player_id"
            case position
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let homePlayers = home.playerList  // all player objects
        let awayPlayers = away.playerList
    }
    
    func makeButtons() {
//      var buttons = [UIButton]()
      var button : UIButton

      var x :CGFloat = 0
      var y :CGFloat = 400.0

//      for (i, name) in playerArray.enumerated() {
//        button = UIButton()
//        // x, y, width, height
//        
//
//
//        let screenSize = UIScreen.main.bounds
//        let screenWidth = screenSize.width
//
//
//        button.frame = CGRect(x: x, y: y, width: screenWidth, height: 100.0)
//        if i % 2 == 0 {
//          button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
//        }
//        else{
//          button.backgroundColor = UIColor.white
//        }
//
//        button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
//
//        //Allow for multi line text \n separated.
//        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
//        button.setTitle(name + "\t\t\t\t\t\t\t\t\t\t " + "#" + playerNum[i] + "\n" + playerPosition[i], for: UIControl.State.normal)
//
//
//
//        button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
//        button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)
//
//        button.tag = i
//
//        scrollView.addSubview(button)
//
//        buttons.append( button )
//        //x = x * 2.0
//        y = y + 100
//
//      }
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
