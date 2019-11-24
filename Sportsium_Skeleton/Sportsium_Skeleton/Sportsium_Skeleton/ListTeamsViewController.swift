//
//  ListTeamsViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/2/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation

class ListTeamsViewController: UIViewController {
    
    var orlandoInfo: TeamInfo?
    var skyBlueInfo: TeamInfo?
    var houstonInfo: TeamInfo?
    var washingtonInfo: TeamInfo?
    var northCarolinaInfo: TeamInfo?
    var reignInfo: TeamInfo?
    var portlandInfo: TeamInfo?
    var chicagoInfo: TeamInfo?
    var utahInfo: TeamInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString = "http://159.89.139.18/sports_check/?league=NWSL"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        }

        guard let data = data else { return }
            do {
                // 3
                //Decode data
                let teams = try JSONDecoder().decode(Teams.self, from: data)
                
                print(teams)
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
        
//        print(orlandoInfo!.cityLocation)
        
        }
        weak var home: UIImageView!
        weak var camera: UIImageView!
        weak var listTeams: UIImageView!
}
