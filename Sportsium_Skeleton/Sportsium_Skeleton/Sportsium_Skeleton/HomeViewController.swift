//
//  HomeViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/12/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var chosenLeague = ""
    
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
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let urlString = "http://159.89.234.82/sports_check/?league=" + chosenLeague
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
                let orlandoInfo = teams.orlandoPride
                let skyBlueInfo = teams.skyBlue
                let houstonInfo = teams.houstonDash
                let washingtonInfo = teams.washingtonSpirit
                let northCarolinaInfo = teams.northCarolinaCourage
                let reignInfo = teams.reign
                let portlandInfo = teams.portlandThorns
                let chicagoInfo = teams.chicagoRedStars
                let utahInfo = teams.utahRoyals
                
                // For Chia & Gustavo - USAGE FOR PLAYERS
//                let playerKeys = teamInfo.players.keys // player numbers: "23", "3"
//                let players = teamInfo.players.values  // all player objects
                
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
}

