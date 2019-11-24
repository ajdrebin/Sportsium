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
            scoring = "Scoring: To score the ball must go into your opponent’s goal. The whole ball needs to be over the line for it to be a legitimate goal. A goal can be scored with any part of the body apart from the hand or arm up to the shoulder."
            rules = ["A match consists of two 45 minutes halves with a 15 minute rest period in between.","Each team can have a minimum off 11 players (including 1 goalkeeper who is the only player allowed to handle the ball within the 18 yard box) and a minimum of 7 players are needed to constitute a match.","The field must be made of either artificial or natural grass. The size of pitches is allowed to vary but must be within 100-130 yards long and 50-100 yards wide. The pitch must also be marked with a rectangular shape around the outside showing out of bounds, two six yard boxes, two 18 yard boxes and a centre circle. A spot for a penalty placed 12 yards out of both goals and centre circle must also be visible.","Each team can name up to 7 substitute players. Substitutions can be made at any time of the match with each team being able to make a maximum of 3 substitutions per side. In the event of all three substitutes being made and a player having to leave the field for injury the team will be forced to play without a replacement for that player.","If teams are still level after extra time then a penalty shootout must take place.","If a ball goes out of play off an opponent in either of the side lines then it is given as a throw in. If it goes out of play off an attacking player on the base line then it is a goal kick. If it comes off a defending player it is a corner kick."]
        }
        
        else {
            object = "Object of the game: The object of basketball is to throw the ball into a hoop to score points. The game is played out on a rectangular court and depending on which section of court you successfully throw a ball into the basket will depend on how many points are scored. The ball can be moved around the by dribbling or passing the ball. At the end of the game the team with the most points is declared the winner."
            scoring = "Scoring: There are three scoring numbers for basketball players. Any basket scored from outside the three point arc will result in three points being scored. Baskets scored within the three point arc will result in two points being scored. Successful free throws will result in 1 point being scored per free throw. The number of free throws will depend on where the foul was committed."
            rules = ["Each team can have a maximum of 5 players on the court at any one time. Substitutions can be made as many times as they wish within the game.","The ball can only be moved by either dribbling (bouncing the ball) or passing the ball. Once a player puts two hands on the ball (not including catching the ball) they cannot then dribble or move with the ball and the ball must be passed or shot.","After the ball goes into a team’s half and they win possession back the ball must then make it back over the half way line within 10 seconds. If the ball fails to do so then a foul will be called and the ball will be turned over.","Each team has 24 seconds to at least shot at the basket. A shot constitutes either going in the basket or hitting the rim of the basket. If after the shot is taken and the ball fails to go in the basket then the shot clock is restarted for another 24 seconds.","The team trying to score a basket is called the offence whilst the team trying to prevent them from scoring is called the defence. The defence must do all they can to stop the offence from scoring by either blocking a shot or preventing a shot from being fired.","After each successful basket the ball is then turned over to the opposition.","Fouls committed throughout the game will be accumulated and then when reached a certain number will be eventually be awarded as a free throw. A free throw involves one playerfrom the offensive team (the player fouled) to take a shot unopposed from the free throw line. Depending on where the foul was committed will depend on the number free throws a player gets.","Violations in basketball include travelling (taking more than one step without bouncing the ball), double dribble (picking the ball up dribbling, stopping then dribbling again with two hands), goaltending (a defensive player interferes with the ball travelling downwards towards the basket) and back court violation (once the ball passes the half way line the offensive team cannot take the ball back over the half way line)."]
        }

        //Get back to the main queue
        DispatchQueue.main.async {
            self.objectLabel.text = league
            self.objectLabel.text = object
            self.scoringLabel.text = scoring
            for value in rules {
                self.bulletLabel.text = self.bulletLabel.text!  + " • " + value + "\n"
             }


        }

    }
}
