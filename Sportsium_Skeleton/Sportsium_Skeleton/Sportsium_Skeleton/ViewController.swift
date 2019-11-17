//
//  ViewController.swift
//  Sportsium_Skeleton
//
//  Created by Alina Drebin on 10/31/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var league = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let selectLeague = UITapGestureRecognizer(target: self, action: #selector(self.selectNWSL(sender:)))

    }
    @IBOutlet weak var chooseSoccerLeague: UIImageView!
    
    @objc func selectNWSL(sender: UITapGestureRecognizer) {
       print("Please Help!")
    }
    
    
//
//    @IBAction func selectNWSL(sender: UITapGestureRecognizer) {
//
//        league = "NWSL"
//        print("league")
//        print(league)
//        performSegue(withIdentifier: "chooseLeague", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "chooseLeague"){
                let displayVC = segue.destination as! HomeViewController
                displayVC.chosenLeague = league
        }
    }

}
