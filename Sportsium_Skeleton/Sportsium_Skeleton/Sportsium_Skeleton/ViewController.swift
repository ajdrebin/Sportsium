//
//  ViewController.swift
//  Sportsium_Skeleton
//
//  Created by Alina Drebin on 10/31/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

var league = ""

var teamsDict = [String: TeamInfo]()

var initiate = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", teamName: "", playerList: [])

var NWSLteams = NWSL(orlandoPride: initiate, skyBlue: initiate, houstonDash: initiate, washingtonSpirit: initiate, northCarolinaCourage: initiate, reign: initiate, portlandThorns: initiate, chicagoRedStars: initiate, utahRoyals: initiate)
var WNBAteams = WNBA(atlantaDream: initiate, chicagoSky: initiate, connecticutSun: initiate, indianaFever: initiate, newYorkLiberty: initiate, washingtonMystics: initiate, dallasWings: initiate, lasVegasAces: initiate, losAngelesSparks: initiate, minnesotaLynx: initiate, phoenixMercury: initiate, seattleStorm: initiate)

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

class ViewController: UIViewController {
    
    var didLoad = false {
        didSet {
            if didLoad == true {
                print("Hello World.")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Home", sender: self)
                }
            }
        }
    }
    
    @IBOutlet weak var wnba_button: UIButton!
    @IBOutlet weak var nwsl_button: UIButton!
    
  @IBOutlet weak var wnba_text_button: UIButton!
  @IBOutlet weak var nwsl_text_button: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nwsl_button.tag = 1
        wnba_button.tag = 2
        nwsl_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        wnba_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
      
        nwsl_text_button.tag = 1
        wnba_text_button.tag = 2
        nwsl_text_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        wnba_text_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
      
      
      
      
      
      
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let btn: UIButton = sender
        teamsDict.removeAll()
        
        if btn.tag == 1 {
            league = "NWSL"
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
                    
                } catch let jsonError {
                    print(jsonError)
                    if let url = Bundle.main.url(forResource: "nwsl", withExtension: "txt") {
                        if let data = NSData(contentsOf: url) {
                            do {
                                NWSLteams = try JSONDecoder().decode(NWSL.self, from: data as Data)
                                teamsDict["orlando_pride"] = NWSLteams.orlandoPride
                               teamsDict["sky_blue"] = NWSLteams.skyBlue
                               teamsDict["houston_dash"] = NWSLteams.houstonDash
                               teamsDict["washington_spirit"] = NWSLteams.washingtonSpirit
                               teamsDict["north_carolina_courage"] = NWSLteams.northCarolinaCourage
                               teamsDict["reign"] = NWSLteams.reign
                               teamsDict["portland_thorns"] = NWSLteams.portlandThorns
                               teamsDict["chicago_red_stars"] = NWSLteams.chicagoRedStars
                               teamsDict["utah_royals"] = NWSLteams.utahRoyals
                                self.didLoad = true
                                print("success")
                            } catch {
                                print("Error!! Unable to parse  nwsl.txt")
                            }
                        }
                    }
                }
                // 5
                self.didLoad = true
            }.resume()
        }
        else{
            league = "WNBA"
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
                    
                } catch let jsonError {
                    print(jsonError)
                    if let url = Bundle.main.url(forResource: "wnba", withExtension: "txt") {
                        if let data = NSData(contentsOf: url) {
                            do {
                                WNBAteams = try JSONDecoder().decode(WNBA.self, from: data as Data)
                                
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
                                self.didLoad = true
                                print("success")
                            } catch {
                                print("Error!! Unable to parse  wnba.txt")
                            }
                        }
                    }
                }
                // 5
                self.didLoad = true
            }.resume()
        }

        print("HELLLO")
//        performSegue(withIdentifier: "Home", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Home"){
            if(!self.didLoad){
                return
            }
            let displayVC = segue.destination as! HomeViewController
            print("league: ", league)
            displayVC.chosenLeague = league
            print("In viewcontroller")
            print(league)
        }
    }
    
//    func loadJson(forFilename fileName: String) -> NWSL {
////        let turl = Bundle.main.url(forResource: fileName, withExtension: "txt")
////        print(turl)
////        let tdata = NSData(contentsOf: turl!)
////        print(tdata)
//
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "txt") {
//            if let data = NSData(contentsOf: url) {
//                do {
//                    NWSLteams = try JSONDecoder().decode(NWSL.self, from: data as Data)
//                    return NWSLteams
//                } catch {
//                    print("Error!! Unable to parse  \(fileName).txt")
//                }
//            }
//            print("Error!! Unable to load  \(fileName).txt")
//        }
//
//        return NWSL
//    }
}
