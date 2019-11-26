//
//  HomeViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/12/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

struct WNBA: Codable {
     let atlantaDream: TeamInfo
     let chicagoSky: TeamInfo
     let connecticutSun: TeamInfo
     let indianaFever: TeamInfo
     let newYorkLiberty: TeamInfo
     let washingtonMystics: TeamInfo
     let dallasWings: TeamInfo
     let lasVegasAces: TeamInfo
     let losAngelesSparks: TeamInfo
     let minnesotaLynx: TeamInfo
     let phoenixMercury: TeamInfo
     let seattleStorm: TeamInfo

     enum CodingKeys: String, CodingKey {
        case atlantaDream = "atlanta_dream"
        case chicagoSky = "chicago_sky"
        case connecticutSun = "connecticut_sun"
        case indianaFever = "indiana_fever"
        case newYorkLiberty = "new_york_liberty"
        case washingtonMystics = "washington_mystics"
        case dallasWings = "dallas_wings"
        case lasVegasAces = "las_vegas_aces"
        case losAngelesSparks = "los_angeles_sparks"
        case minnesotaLynx = "minnesota_lynx"
        case phoenixMercury = "phoenix_mercury"
        case seattleStorm = "seattle_storm"
    }
}
struct NWSL: Codable {
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
        case reign = "reign"
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
     let teamName: String
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
         case teamName = "team_name"
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


// GLOBAL VARIABLES
var teamsDict = [String: TeamInfo]()

var initiate = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", teamName: "", playerList: [])

var NWSLteams = NWSL(orlandoPride: initiate, skyBlue: initiate, houstonDash: initiate, washingtonSpirit: initiate, northCarolinaCourage: initiate, reign: initiate, portlandThorns: initiate, chicagoRedStars: initiate, utahRoyals: initiate)
var WNBAteams = WNBA(atlantaDream: initiate, chicagoSky: initiate, connecticutSun: initiate, indianaFever: initiate, newYorkLiberty: initiate, washingtonMystics: initiate, dallasWings: initiate, lasVegasAces: initiate, losAngelesSparks: initiate, minnesotaLynx: initiate, phoenixMercury: initiate, seattleStorm: initiate)
    
var league = ""

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
    var didLoad = false
    
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

        let urlString = "http://159.89.139.18/sports_check/?league=" + league
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
                if (league == "NWSL") {
                    NWSLteams = try JSONDecoder().decode(NWSL.self, from: data)

                    teamsDict["orlando_pride"] = NWSLteams.orlandoPride
                    teamsDict["sky_blue"] = NWSLteams.skyBlue
                    teamsDict["houston_dash"] = NWSLteams.houstonDash
                    teamsDict["washington_spirit"] = NWSLteams.washingtonSpirit
                    teamsDict["north_carolina_courage"] = NWSLteams.northCarolinaCourage
                    teamsDict["reign"] = NWSLteams.reign
                    teamsDict["portland_thorns"] = NWSLteams.portlandThorns
                    teamsDict["chicago_red_stars"] = NWSLteams.chicagoRedStars
                    teamsDict["utah_royals"] = NWSLteams.utahRoyals
                }
                else {
                    WNBAteams = try JSONDecoder().decode(WNBA.self, from: data)

                    teamsDict["atlanta_dream"] = WNBAteams.atlantaDream
                    teamsDict["chicago_sky"] = WNBAteams.chicagoSky
                    teamsDict["connecticut_sun"] = WNBAteams.connecticutSun
                    teamsDict["indiana_fever"] = WNBAteams.indianaFever
                    teamsDict["new_york_liberty"] = WNBAteams.newYorkLiberty
                    teamsDict["washington_mystics"] = WNBAteams.washingtonMystics
                    teamsDict["dallas_wings"] = WNBAteams.dallasWings
                    teamsDict["las_vegas_aces"] = WNBAteams.lasVegasAces
                    teamsDict["los_angeles_sparks"] = WNBAteams.losAngelesSparks
                    teamsDict["minnesota_lynx"] = WNBAteams.minnesotaLynx
                    teamsDict["phoenix_mercury"] = WNBAteams.phoenixMercury
                    teamsDict["seattle_storm"] = WNBAteams.seattleStorm
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
                
                
                // 4
                //Get back to the main queue

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

            } catch let jsonError {
                print(jsonError)
            }
            // 5
            self.didLoad = true
            }.resume()
        
         }
     @objc func buttonAction(sender: UIButton!) {
       let btn: UIButton = sender
    
       if btn.tag == 1 {
        // Set Team Info to Pass
        if (league == "NWSL"){
            home = "orlando_pride"
            away = "chicago_red_stars"
        }
        if (league == "WNBA"){
            home = "atlanta_dream"
            away = "chicago_sky"
        }
        
       }
       else if btn.tag == 2 {
        // Set Team Info to Pass
        if (league == "NWSL"){
            home = "reign"
            away = "portland_thorns"
        }
        if (league == "WNBA"){
            home = "los_angeles_sparks"
            away = "las_vegas_aces"
        }
       }
       else{
        // Set Team Info to Pass
        if (league == "NWSL"){
            home = "utah_royals"
            away = "north_carolina_courage"
        }
        if (league == "WNBA"){
            home = "seattle_storm"
            away = "phoenix_mercury"
        }
       }
        performSegue(withIdentifier: "Game", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Game"){
            if(!self.didLoad){
                return
            }
            let displayVC = segue.destination as! GameInfoViewController
            displayVC.home = home
            displayVC.away = away
        }
    }
}

