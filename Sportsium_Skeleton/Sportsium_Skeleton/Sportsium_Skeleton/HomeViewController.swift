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
    
//    struct JSONGameInfo: Codable {
//        let houston-dash: Int

//        let home: String
//        let away: String
//        let stadium: String
//        let time: String
        
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//    }
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TEST
        print("here")

        homeLabel.text = "|"+chosenLeague+"|"
        
        print(chosenLeague)
        
//        var request = URLRequest(url: URL(string: "http://159.89.234.82/sports_check/?league=NWSL")!)
//request.httpMethod = "GET"
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let session = URLSession.shared
//let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//    do {
//        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//      print(json["portland_thorns"]!["city_location"]);
//    } catch {
//        print("error")
//    }
//})
//
//
//
//
//task.resume()


      
      
      
      
      
      
      
    
//        // 1
//        let urlString = "http://159.89.234.82/sports_check/?league=NWSL"
//        guard let url = URL(string: urlString) else { return }
//
//        // 2
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//
//            guard let data = data else { return }
//            do {
//                // 3
//                //Decode data
//                let JSONData = try JSONDecoder().decode(JSONGameInfo.self, from: data)
//                print("json: ", JSONData)
//                // 4
//                //Get back to the main queue
//                DispatchQueue.main.async {
//                    self.homeLabel.text = String(JSONData.houston_dash)
//
////                    self.homeLabel.text = JSONData.home
////                    self.awayLabel.text = JSONData.away
////                    self.timeLabel.text = JSONData.time
////                    self.stadiumLabel.text = JSONData.stadium
//                }
//
//            } catch let jsonError {
//                print(jsonError)
//            }
//            // 5
//            }.resume()
        
    }
}

