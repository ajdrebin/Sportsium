//
//  HomeViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/12/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

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
    
    // Initializing Team Info to Send
    var home = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var away = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var orlandoInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var skyBlueInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var houstonInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var washingtonInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var northCarolinaInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var reignInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var portlandInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var chicagoInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    var utahInfo = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", playerList: [])
    
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
        let urlString = "http://159.89.139.18/sports_check/?league=" + chosenLeague
        guard let url = URL(string: urlString) else { return }

        // 2
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }

            guard let data = data else { return }
            do {
                // 3
                //Decode data
                let teams = try JSONDecoder().decode(Teams.self, from: data)
                
                // Teams
                self.orlandoInfo = teams.orlandoPride
                self.skyBlueInfo = teams.skyBlue
                self.houstonInfo = teams.houstonDash
                self.washingtonInfo = teams.washingtonSpirit
                self.northCarolinaInfo = teams.northCarolinaCourage
                self.reignInfo = teams.reign
                self.portlandInfo = teams.portlandThorns
                self.chicagoInfo = teams.chicagoRedStars
                self.utahInfo = teams.utahRoyals
                
                // 4
                //Get back to the main queue
//                DispatchQueue.main.async {
//                    self.homeLabel.text = String(JSONData.orlando_pride)
//                }
            } catch let jsonError {
                print(jsonError)
            }
            // 5
            }.resume()
         }
     @objc func buttonAction(sender: UIButton!) {
       let btn: UIButton = sender
    
       if btn.tag == 1 {
        print(chicagoInfo)
        // Set Team Info to Pass
        self.home = chicagoInfo
        self.away = orlandoInfo
       }
       else if btn.tag == 2 {
        // Set Team Info to Pass
        self.home = reignInfo
        self.away = portlandInfo
       }
       else{
        // Set Team Info to Pass
        self.home = utahInfo
        self.away = northCarolinaInfo
       }
        performSegue(withIdentifier: "Game", sender: self)
        performSegue(withIdentifier: "ListTeams", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Game"){
                let displayVC = segue.destination as! GameInfoViewController
                displayVC.home = self.home
                displayVC.away = self.away
//                print(home, away)
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "ListTeams"){
//                let displayVC = segue.destination as! ListTeamsViewController
//                displayVC.orlandoInfo = orlandoInfo
//                displayVC.skyBlueInfo = skyBlueInfo
//                displayVC.houstonInfo = houstonInfo
//                displayVC.washingtonInfo = washingtonInfo
//                displayVC.northCarolinaInfo = northCarolinaInfo
//                displayVC.reignInfo = reignInfo
//                displayVC.portlandInfo = portlandInfo
//                displayVC.chicagoInfo = chicagoInfo
//                displayVC.utahInfo = utahInfo
//        }
//    }
}

