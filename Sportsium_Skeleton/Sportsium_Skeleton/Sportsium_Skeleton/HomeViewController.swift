//
//  HomeViewController.swift
//  Sportsium_Skeleton
//
//  Created by Jess Cheng on 11/12/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = URL(string:"http://159.89.234.82/game_check/") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { ( data, response, error ) in
            if let response = response {
                print("response: ", response)
            }
            if let data = data {
                print("data: ", data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
}

