//
//  RulesViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/10/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation

class RulesViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var scoringLabel: UILabel!
    @IBOutlet weak var bulletLabel: UILabel!
    
    override func viewDidLoad() {
        var object = ""
        var scoring = ""
        var rules:[String]
        let credit = "https://www.rulesofsport.com/sports"

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (league == "NWSL") {
            object = "Object of the game: The aim of football is to score more goals then your opponent in 90 min.After the first 45 minutes players will take a 15 minute rest period called half time. The second 45 minutes will resume and any time deemed fit to be added on by the referee (injury time) will be accordingly."
            scoring = "Scoring: To score the ball must go into your opponent’s goal, crossing the line. A goal can be scored with any part of the body apart from the hand or arm up to the shoulder."
            rules = ["A match consists of two 45 minutes halves with a 15 minute rest period in between.","Each team can have a minimum off 11 players (including 1 goalkeeper who is the only player allowed to handle the ball within the 18 yard box) and a minimum of 7 players are needed to constitute a match.","Each team can name up to 7 substitute player.","If a ball goes out of play off an opponent in either of the side lines then it is given as a throw in. If it goes out of play off an attacking player on the base line then it is a goal kick. If it comes off a defending player it is a corner kick."]
        }
        
        else {
            object = "Object of the game: The object of basketball is to throw the ball into a hoop to score points. Depending on which section of court you successfully throw a ball into the basket will depend on how many points are scored."
            scoring = "Scoring: There are three scoring numbers: any basket scored from outside the three point arc will result in three points being scored, baskets scored within the three point arc will result in two points being scored, successful free throws will result in 1 point being scored."
            rules = ["Maximum of 5 players on the court at any one time.","The ball can only be moved by either dribbling (bouncing the ball) or passing the ball. Once a player puts two hands on the ball (not including catching the ball) they cannot then dribble or move with the ball and the ball must be passed or shot.","Each team has 24 seconds to at least shot at the basket.","Violations in basketball include travelling, double dribble, goaltending, and back court violation."]
        }

        //Get back to the main queue
        DispatchQueue.main.async {
            self.objectLabel.text = object
            self.scoringLabel.text = scoring
            for value in rules {
                self.bulletLabel.text = self.bulletLabel.text!  + "\n• " + value
             }


        }

    }
}
