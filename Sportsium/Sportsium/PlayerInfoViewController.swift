//
//  PlayerInfo.swift
//  
//
//  Created by Chia Chen on 10/30/19.
//  Copyright © 2019 Chia Chen. All rights reserved.
//

import UIKit

class PlayerInfoViewController: UIViewController {
  
  @IBOutlet var mainView: UIView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var playerNameLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var teamLogo: UIImageView!
  
  
  var teamName = "orlando_pride"
  var playerName = "Joanna Boyles"
  var playerNum = "25"
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    textView.isUserInteractionEnabled = false
    
    mainView.backgroundColor = UIColor.init(displayP3Red: 128/255, green: 196/255, blue: 249/255, alpha: 1)
    editNumberLabel()
    addTeamLogo()
    
    setPlayerName()
    makeTextView()
    
    
  }
  
  
  
  func makeTextView() {
    textView.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
    textView.clipsToBounds = true;
    textView.layer.cornerRadius = 10.0;

    textView.text = "\n\n\n\n\n" + playerName.uppercased()
    textView.text += " \n\n\n\nhello"
    
  }
  
  
  func setPlayerName() {
    playerNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
    playerNameLabel.text = playerName.uppercased()
    
    var x = textView.frame.width
    var y = textView.frame.origin.y + 30

    playerNameLabel.frame = CGRect(x: 20, y: y, width: x, height: 20)
    playerNameLabel.textAlignment = .center;
    playerNameLabel.textColor = UIColor.init(displayP3Red: 26/255, green: 97/255, blue: 170/255, alpha: 1)
  }
  
  
  
  func editNumberLabel() {
    numberLabel.clipsToBounds = true;
    numberLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
    numberLabel.textAlignment = .center
    numberLabel.layer.cornerRadius = 10.0;
    numberLabel.text = playerNum
    numberLabel.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
    numberLabel.textColor = UIColor.init(displayP3Red: 63/255, green: 164/255, blue: 247/255, alpha: 1)
    
    
  }
  
  
  func addTeamLogo(){
    var imageName = teamName + ".png"
    
    teamLogo.image = UIImage(named: imageName)
    
  }
  
  
}


