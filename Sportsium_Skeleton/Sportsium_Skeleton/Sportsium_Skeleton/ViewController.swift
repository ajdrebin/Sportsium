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
  
  @IBOutlet weak var wnba_button: UIButton!
  @IBOutlet weak var nwsl_button: UIButton!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        nwsl_button.tag = 1
        wnba_button.tag = 2
        nwsl_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        wnba_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
  
    @objc func buttonAction(sender: UIButton!) {
      let btn: UIButton = sender
   
      if btn.tag == 1 {
        league = "NWSL"
      }
      else{
        league = "WNBA"
      }
      performSegue(withIdentifier: "Home", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Home"){
                let displayVC = segue.destination as! HomeViewController
            print("league: ", league)
                displayVC.chosenLeague = league
        }
    }

}
