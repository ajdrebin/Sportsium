//
//  TeamInfoViewController.swift
//  Sportsium
//
//  Created by Chia Chen on 10/21/19.
//  Copyright © 2019 Chia Chen. All rights reserved.
//

import UIKit


class TeamInfoViewController: UIViewController {
  
  
  
  @IBOutlet var mainView: UIView!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var innerView: UIView!
  
  @IBOutlet weak var innerViewHeight: NSLayoutConstraint!
  
  @IBOutlet weak var nav_label: UILabel!


  var home_team_name:String!
  var away_team_name:String!
  
  

  var home = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", teamName: "", playerList: [])
  
  
  

  
  var players = [Player]()
  
  var playerArray = [String]()       // Names
  var playerNum = [String]()         // Number
  var playerPosition = [String]()    //Position

  var teamName = "orlando_pride"
  var display_teamName = "orlando pride"

  override func viewDidLoad() {
    print(home)
    
    
    
    teamName = home.teamName
    
    
    //Removed the underscore
    display_teamName = teamName.replacingOccurrences(of: "_", with: " ", options: NSString.CompareOptions.literal, range: nil)
    // Captialize first letter
    display_teamName = display_teamName.capitalizingFirstLetter()
    
    

    
    
    players = home.playerList
    
    for p in players {
      var name = p.firstName + " " +  p.lastName
      playerArray.append(name)
      playerPosition.append(p.position)
      playerNum.append(p.number)
    }
    
    
  
    var scrollHeight = 480 + 100 * playerArray.count
    innerViewHeight.constant = CGFloat(scrollHeight)
    super.viewDidLoad()
    makeButtons()
    addBackgroundImage()
    addTeamLogo()
    playerLabel()
    addTeamNameLabel()
    makeBackButton()
    addNavBar()
    
    
  }
  
  func makeBackButton() {
    var button : UIButton
    button = UIButton()
    // x, y, width, height
    var x = 0
    var y = 10
    button.frame = CGRect(x: -20, y: 30, width: 100, height: 40)
    button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
    button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 0)
    button.setTitle("< Back", for: UIControl.State.normal)
    
    button.addTarget(self, action: #selector(segueGameInfo), for: UIControl.Event.touchDown)
    
    
    
    scrollView.addSubview(button)
    
  }
  
  func addNavBar() {
    let label = UILabel()
    label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
    label.backgroundColor = UIColor.init(displayP3Red: 33/255, green: 133/255, blue: 247/255, alpha: 1)
    
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    label.frame = CGRect(x: 0, y: 720, width: screenWidth, height: 100)
    
    
    let home_btn = UIButton()
    var imageName = "home.png"
    var image = UIImage(named: imageName)
    
    home_btn.setImage(image, for: [])
    
    home_btn.frame = CGRect(x: 60, y: 750, width: 38, height: 30)
    
    home_btn.layer.zPosition = 1;
    
    home_btn.addTarget(self, action: #selector(segueHome), for: UIControl.Event.touchDown)

    mainView.addSubview(home_btn)
    
    
    let explore_btn = UIButton()
    imageName = "explore.png"
    image = UIImage(named: imageName)
    
    explore_btn.setImage(image, for: [])
    
    explore_btn.frame = CGRect(x: 275, y: 750, width: 38, height: 38)
    
    explore_btn.layer.zPosition = 1;
    
    home_btn.addTarget(self, action: #selector(segueListTeams), for: UIControl.Event.touchDown)
    
    mainView.addSubview(explore_btn)
    

    let camera_btn = UIButton()
    imageName = "circle.png"
    image = UIImage(named: imageName)
    
    camera_btn.setImage(image, for: [])
    
    camera_btn.frame = CGRect(x: 145, y: 710, width: 85, height: 85)
    
    camera_btn.layer.zPosition = 1;
    
    camera_btn.addTarget(self, action: #selector(segueCamera), for: UIControl.Event.touchDown)
    
    
    
    mainView.addSubview(camera_btn)

    mainView.addSubview(label)
    
    
  }
  
  
  @objc func segueCamera(sender: UIButton!) {
     let btn: UIButton = sender
     print(btn.titleLabel?.text)
     performSegue(withIdentifier: "Camera", sender: self)
   }
  
  
  
  // NEED TO CHANGE THIS.
  @objc func segueHome(sender: UIButton!) {
      let btn: UIButton = sender
      print(btn.titleLabel?.text)
      performSegue(withIdentifier: "Home", sender: self)
    }
  
  @objc func segueGameInfo(sender: UIButton!) {
    let btn: UIButton = sender
    print(btn.titleLabel?.text)
    performSegue(withIdentifier: "GameInfo", sender: self)
  }
  
  @objc func segueListTeams(sender: UIButton!) {
      let btn: UIButton = sender
      print(btn.titleLabel?.text)
      performSegue(withIdentifier: "ListTeams", sender: self)
    }
  
  
  
  
  func addBackgroundImage() {
    var imageName = "teaminfo_background.jpeg"

    var image = UIImage(named: imageName)
    var imageView = UIImageView(image: image!)

    
    imageView.frame = CGRect(x: -30, y: 20, width: 475, height: 300)
  
    scrollView.addSubview(imageView)
    
    
    imageName = "black.jpeg"
    image = UIImage(named: imageName)?.alpha(0.7)
    imageView = UIImageView(image: image!)
    imageView.frame = CGRect(x: 0, y: 20, width: scrollView.frame.width, height: 300)
    scrollView.addSubview(imageView)
  }
  
  
  func addTeamLogo() {
    let imageName =  teamName + ".png"
    let image = UIImage(named: imageName)
    let imageView = UIImageView(image: image!)
    imageView.frame = CGRect(x: 20, y: 80, width: 150, height: 150)
    
    
    scrollView.addSubview(imageView)
  }
  
  
  func makeButtons() {
    var buttons = [UIButton]()
    var button : UIButton

    var x :CGFloat = 0
    var y :CGFloat = 400.0

    for (i, name) in playerArray.enumerated() {
      button = UIButton()
      // x, y, width, height
      
      
      
      let screenSize = UIScreen.main.bounds
      let screenWidth = screenSize.width
      
      
      button.frame = CGRect(x: x, y: y, width: screenWidth, height: 100.0)
      if i % 2 == 0 {
        button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
      }
      else{
        button.backgroundColor = UIColor.white
      }
      
      button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
      
      //Allow for multi line text \n separated.
      button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
      button.setTitle(name + "\t\t\t\t\t\t\t\t\t\t " + "#" + playerNum[i] + "\n" + playerPosition[i], for: UIControl.State.normal)
      

      
      button.addTarget(self, action: #selector(pressBtn), for: UIControl.Event.touchDown)
      button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
      button.addTarget(self, action: #selector(releaseBtn), for: .touchUpInside)
      button.addTarget(self, action: #selector(releaseBtn), for: .touchUpOutside)

      button.tag = i
      
      scrollView.addSubview(button)
      
      buttons.append( button )
      //x = x * 2.0
      y = y + 100
      
    }
  }
  
  
  
  func playerLabel() {
    let label = UILabel()
    label.text = "Players"
    label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
    label.textColor = UIColor.init(displayP3Red: 50/255, green: 153/255, blue: 247/255, alpha: 1)
    
    
    label.frame = CGRect(x: 20, y: 350, width: scrollView.frame.width, height: 20)
    scrollView.addSubview(label)
  }
  

  
  func addTeamNameLabel() {
    let label = UILabel()
    label.text = display_teamName.uppercased()
    label.adjustsFontSizeToFitWidth=true;
    
    
    //label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
    
    
    
    label.textColor = UIColor.white
    label.numberOfLines = 2
    
    
   
    label.adjustsFontSizeToFitWidth=true;
      label.minimumScaleFactor=0.5;
    
    


    
    label.frame = CGRect(x: 190, y: 120, width: scrollView.frame.width, height: 20)
    scrollView.addSubview(label)
  }
  
  
  var last_pressed = "none"
  @objc func buttonAction(sender: UIButton!) {
    let btn: UIButton = sender
    print(btn.titleLabel?.text)
    last_pressed = btn.titleLabel!.text!
    performSegue(withIdentifier: "PlayerInfo", sender: self)
  }

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if(segue.identifier == "PlayerInfo") {
             let displayVC = segue.destination as! PlayerInfoViewController
             displayVC.button_text = last_pressed
            displayVC.team_obj = home
      
      
      displayVC.home_team_name = home_team_name
       displayVC.away_team_name = away_team_name
      
              let full_arr = last_pressed.components(separatedBy: "\t")
              print(full_arr)
      
      
              //This thing ends in a trailing white space lol
              let playerName = full_arr[0] + " " + full_arr[1]
              
      
              // Find specific player for passing data to PlayerInfo
              for p in players {
                  
                 var name = p.firstName + " " +  p.lastName + " "    //account for trailing whitespace
                if (name  == playerName) {
                  displayVC.player_obj = p
                }
              }
      
      
      
      
      
      
      
      
     }
  
  if(segue.identifier == "GameInfo") {
    let displayVC = segue.destination as! GameInfoViewController
     displayVC.home = home_team_name
     displayVC.away = away_team_name
  }
  
  
 }

  @objc func pressBtn(sender: UIButton!) {
    let btn: UIButton = sender
    btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
  }
  
  @objc func releaseBtn(sender: UIButton!) {
    let btn: UIButton = sender
    btn.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
  }


  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
}

//source
// https://stackoverflow.com/questions/28517866/how-to-set-the-alpha-of-an-uiimage-in-swift-programmatically
extension UIImage {
  
  func alpha(_ value:CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}
