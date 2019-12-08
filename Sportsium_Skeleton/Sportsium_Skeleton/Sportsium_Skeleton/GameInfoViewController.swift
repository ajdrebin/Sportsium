//
//  GameInfoViewController.swift
//  Sportsium_Skeleton
//
//  Created by Alina Drebin on 10/31/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    var home: String?
    var away: String?
    
    var homePlayers:[Player] = []
    var awayPlayers:[Player] = []
    
    override func viewDidLoad() {
        //        print(home)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homePlayers = teamsDict[home!]!.playerList  // all player objects
        awayPlayers = teamsDict[away!]!.playerList
        makeButtons()
    }
    
    func makeButtons() {
        //      var buttons = [UIButton]()
        var button : UIButton
        
        var x :CGFloat = 0
        var y :CGFloat = 250.0
        
        var teamOneLabel:UILabel = UILabel()
        teamOneLabel.tag = 1
        var teamTwoLabel:UILabel = UILabel()
        teamTwoLabel.tag = 2
        teamOneLabel.frame = CGRect(x: 60, y: 50, width: 75, height: 75)
        teamOneLabel.text = home
        teamTwoLabel.text = away
        teamTwoLabel.frame = CGRect(x: 235, y: 50, width: 75, height: 75)
        teamTwoLabel.adjustsFontSizeToFitWidth = true
        teamOneLabel.adjustsFontSizeToFitWidth = true
        mainView.addSubview(teamOneLabel)
        mainView.addSubview(teamTwoLabel)
        
        var startingLabel:UILabel = UILabel()
        startingLabel.frame = CGRect(x: 145, y: 190, width: 150, height: 75)
        startingLabel.text = "Starting Roster"
        startingLabel.font = .systemFont(ofSize: 12)
        mainView.addSubview(startingLabel)
        
        var teamLogoImageView:UIImageView = UIImageView()
        var teamLogo2ImageView:UIImageView = UIImageView()
        teamLogoImageView.tag = 1
        teamLogoImageView.tag = 2
        
        var teamLogo1:UIImage = UIImage(named:home!)!
        var teamLogoTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTeam))
        teamOneLabel.addGestureRecognizer(teamLogoTap)
        teamLogoTap.name = home
        //        teamLogoTap.delegate = self as? UIGestureRecognizerDelegate
        teamLogoImageView.addGestureRecognizer(teamLogoTap)
        teamLogoImageView.isUserInteractionEnabled = true
        
        teamLogoImageView.frame = CGRect(x: 60, y: 125, width: 75, height: 75)
        teamLogoImageView.contentMode = UIView.ContentMode.scaleAspectFit;
        teamLogoImageView.image = teamLogo1
        mainView.addSubview(teamLogoImageView)
        
        var teamLogo2:UIImage = UIImage(named:away!)!
        var teamLogo2Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTeam))
        teamLogo2Tap.name = away
        teamTwoLabel.addGestureRecognizer(teamLogo2Tap)
        teamLogo2ImageView.addGestureRecognizer(teamLogo2Tap)
        teamLogo2ImageView.isUserInteractionEnabled = true
        
        teamLogo2ImageView.frame = CGRect(x: 235, y: 125, width: 75, height: 75)
        teamLogo2ImageView.contentMode = UIView.ContentMode.scaleAspectFit;
        teamLogo2ImageView.image = teamLogo2
        mainView.addSubview(teamLogo2ImageView)
        
        y = 250
        for (i, playerInd) in homePlayers.enumerated() {
            if i > 10 && league == "NWSL" {
                break
            }
            
            if i > 4 && league == "WNBA" {
                break
            }
            
            var playerLabel:UILabel = UILabel()
            playerLabel.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width/2, height: 40)
            var playerLabelTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPlayer))
            playerLabelTap.name = String(i)
            playerLabel.addGestureRecognizer(playerLabelTap)
            playerLabel.isUserInteractionEnabled = true
            if i % 2 == 0 {
                playerLabel.backgroundColor = UIColor.white
            }
            else{
                playerLabel.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
            }
            mainView.addSubview(playerLabel)
            var playerNumber:UILabel = UILabel()
            playerNumber.text = playerInd.number;
            playerNumber.frame = CGRect(x: 25, y: y, width: 40, height: 40)
            playerNumber.adjustsFontSizeToFitWidth = true
            playerNumber.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            mainView.addSubview(playerNumber)
            var playerName:UILabel = UILabel()
            playerName.text = playerInd.firstName + " " + playerInd.lastName
            playerName.adjustsFontSizeToFitWidth = true
            playerName.font = .systemFont(ofSize: 10.5)
            playerName.frame = CGRect(x: 65, y: y, width: 100, height: 20)
            playerName.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            mainView.addSubview(playerName)
            var playerPosition:UILabel = UILabel()
            playerPosition.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            playerPosition.text = playerInd.position
            playerPosition.adjustsFontSizeToFitWidth = true
            playerPosition.frame = CGRect(x: 65, y: y + 20, width: 100, height: 20)
            playerPosition.font = .systemFont(ofSize: 11)
            mainView.addSubview(playerPosition)
            
            y = y + 40
        }
        
        y = 250
        
        
        
        for (i, playerInd) in awayPlayers.enumerated() {
                        if i > 10 && league == "NWSL" {
                break
            }
            
            if i > 4 && league == "WNBA" {
                break
            }
            
            var playerLabel:UILabel = UILabel()
            playerLabel.frame = CGRect(x: UIScreen.main.bounds.width/2, y: y, width: UIScreen.main.bounds.width/2, height: 40)
            var playerLabelTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPlayer))
            playerLabelTap.name = String(i + 11)
            playerLabel.addGestureRecognizer(playerLabelTap)
            playerLabel.isUserInteractionEnabled = true
            if i % 2 == 0 {
                playerLabel.backgroundColor = UIColor.white
            }
            else{
                playerLabel.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
            }
            mainView.addSubview(playerLabel)
            var playerNumber:UILabel = UILabel()
            playerNumber.text = playerInd.number;
            playerNumber.frame = CGRect(x: UIScreen.main.bounds.width/2 + 25, y: y, width: 40, height: 40)
            playerNumber.adjustsFontSizeToFitWidth = true
            playerNumber.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            mainView.addSubview(playerNumber)
            var playerName:UILabel = UILabel()
            playerName.text = playerInd.firstName + " " + playerInd.lastName
            playerName.adjustsFontSizeToFitWidth = true
            playerName.font = .systemFont(ofSize: 10.5)
            playerName.frame = CGRect(x: UIScreen.main.bounds.width/2 + 65, y: y, width: 100, height: 20)
            playerName.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            mainView.addSubview(playerName)
            var playerPosition:UILabel = UILabel()
            playerPosition.textColor = UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1)
            playerPosition.text = playerInd.position
            playerPosition.adjustsFontSizeToFitWidth = true
            playerPosition.frame = CGRect(x: UIScreen.main.bounds.width/2 + 65, y: y + 20, width: 100, height: 20)
            playerPosition.font = .systemFont(ofSize: 11)
            mainView.addSubview(playerPosition)
            
            y = y + 40
            
        }
        
    }
    
    
    
    var last_pressed = 0
    
    @objc func tapPlayer(sender:AnyObject) {
        var sender = sender
        //      print(btn.titleLabel?.text)
        last_pressed = Int(sender.name)!
        performSegue(withIdentifier: "PlayerInfo", sender: self)
    }
    
    var sendTeam = ""
    @objc func tappedTeam(sender:AnyObject) {
        var sender = sender
        
        sendTeam = sender.name
        
        performSegue(withIdentifier: "Team", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PlayerInfo"){
            let displayVC = segue.destination as! PlayerInfoViewController
            
            if last_pressed > 10 {
                displayVC.player_obj = awayPlayers[last_pressed - 11]
                displayVC.team_obj = teamsDict[away!]!
            }
            else {
                displayVC.player_obj = homePlayers[last_pressed]
                displayVC.team_obj = teamsDict[home!]!
            }
            displayVC.home_team_name = home
            displayVC.away_team_name = away
            displayVC.prev_page = "GameInfo"
        }
        if(segue.identifier == "Team"){
                let displayVC = segue.destination as! TeamInfoViewController
            displayVC.team_obj = teamsDict[sendTeam]!
            displayVC.home_team_name = home
            displayVC.away_team_name = away
          displayVC.prev_page = "GameInfo"
        }
      
      if (segue.identifier == "Home") {
        let displayVC = segue.destination as! HomeViewController
        displayVC.chosenLeague = league
        
      }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if(segue.identifier == "PlayerInfo"){
    //                let displayVC = segue.destination as! PlayerInfoViewController
    //                displayVC.button_text = last_pressed
    //        }
    //    }
    
    // might need to change
    
    @IBOutlet var mainView: UIView!
    
    
}
