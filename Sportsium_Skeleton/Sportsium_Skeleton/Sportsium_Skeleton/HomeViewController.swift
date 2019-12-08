//
//  HomeViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/12/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

// GLOBAL VARIABLES

var home = ""
var away = ""

class HomeViewController: UIViewController {
    var chosenLeague = ""
    
    @IBOutlet weak var home1: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    // Game Buttons
    @IBOutlet weak var game1: UIButton!
    @IBOutlet weak var game2: UIButton!
    @IBOutlet weak var game3: UIButton!
    
    @IBOutlet weak var game1home: UIImageView!
    @IBOutlet weak var game1away: UIImageView!
    @IBOutlet weak var game1stadium: UILabel!
    @IBOutlet weak var game1location: UILabel!
    
    @IBOutlet weak var game2home: UIImageView!
    @IBOutlet weak var game2away: UIImageView!
    @IBOutlet weak var game2stadium: UILabel!
    @IBOutlet weak var game2location: UILabel!
    
    @IBOutlet weak var game3home: UIImageView!
    @IBOutlet weak var game3away: UIImageView!
    @IBOutlet weak var game3stadium: UILabel!
    @IBOutlet weak var game3location: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting tags for buttons
        game1.tag = 1
        game2.tag = 2
        game3.tag = 3
        
        game1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        game2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        game3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        // 1
        // Set league
        if(league == ""){
            league = self.chosenLeague
        }
        else{
            if(league != self.chosenLeague && self.chosenLeague != ""){
                league = self.chosenLeague
                teamsDict.removeAll()
            }
        }
        
        if (league == "WNBA") {
           DispatchQueue.main.async {
               self.game1home.image = UIImage(named:"atlanta_dream")
               self.game1away.image = UIImage(named:"chicago_sky")
               self.game1stadium.text = "Gateway Center Arena"
               self.game1location.text = "College Park, Georgia"
               
               self.game2home.image = UIImage(named:"los_angeles_sparks")
               self.game2away.image = UIImage(named:"las_vegas_aces")
               self.game2stadium.text = "Staples Center"
               self.game2location.text = "LA, California"
               
               self.game3home.image = UIImage(named:"seattle_storm")
               self.game3away.image = UIImage(named:"phoenix_mercury")
               self.game3stadium.text = "ShoWare Center"
               self.game3location.text = "Kent, Washington"
           }
       }

                if(league == "NWSL"){
                    // Set default home and away
                    home = "orlando_pride"
                    away = "chicago_red_stars"
                }
                if(league == "WNBA"){
                    // Set default home and away
                    home = "atlanta_dream"
                    away = "chicago_sky"
                }

         }
     @objc func buttonAction(sender: UIButton!) {
       let btn: UIButton = sender

        if league == "NWSL" {
           if btn.tag == 1 {
            // Set Team Info to Pass
            home = "orlando_pride"
            away = "chicago_red_stars"
            league = "NWSL"
           }
           else if btn.tag == 2 {
            // Set Team Info to Pass
            home = "reign"
            away = "portland_thorns"
            league = "NWSL"
           }
           else{
            // Set Team Info to Pass
            home = "utah_royals"
            away = "north_carolina_courage"
            league = "NWSL"
           }
        }
        else {
          if btn.tag == 1 {
           // Set Team Info to Pass
           home = "atlanta_dream"
           away = "chicago_sky"
           league = "WNBA"
          }
          else if btn.tag == 2 {
           // Set Team Info to Pass
           home = "los_angeles_sparks"
           away = "las_vegas_aces"
           league = "WNBA"
          }
          else{
           // Set Team Info to Pass
           home = "seattle_storm"
           away = "phoenix_mercury"
           league = "WNBA"
          }



      }
      


        performSegue(withIdentifier: "Game", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Game"){
            let displayVC = segue.destination as! GameInfoViewController
            displayVC.home = home
            displayVC.away = away
        }
    }
}

