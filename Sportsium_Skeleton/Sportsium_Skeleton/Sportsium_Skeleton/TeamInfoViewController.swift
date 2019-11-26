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
  
  
  
  //add this change to prepare in ListTeams and GameInfo segues to this TeamInfo
  var prev_page:String!     //GameInfo or ListTeams    - for use with back button
  
  

  
  // Change this in GameInfo
  var team_obj = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", teamName: "", playerList: [])
  
  
  

  
  var players = [Player]()
  
  var playerArray = [String]()       // Names
  var playerNum = [String]()         // Number
  var playerPosition = [String]()    //Position

  var teamName = "orlando_pride"
  var display_teamName = "orlando pride"
  
//  case atlantaDream = "atlanta_dream"
//    case chicagoSky = "chicago_sky"
//    case connecticutSun = "connecticut_sun"
//    case indianaFever = "indiana_fever"
//    case newYorkLiberty = "new_york_liberty"
//    case washingtonMystics = "washington_mystics"
//    case dallasWings = "dallas_wings"
//    case lasVegasAces = "las_vegas_aces"
//    case losAngelesSparks = "los_angeles_sparks"
//    case minnesotaLynx = "minnesota_lynx"
//    case phoenixMercury = "phoenix_mercury"
//    case seattleStorm = "seattle_storm"
  
  var wnba_social_media = ["atlanta_dream":["tt":"https://twitter.com/atlantadream", "ig":"https://www.instagram.com/atlantadream/", "fb":"https://www.facebook.com/atlantadream"],

                           "chicago_sky":["tt":"https://twitter.com/wnbachicagosky", "ig":"https://www.instagram.com/chicagosky/", "fb":"https://www.facebook.com/chicagosky/"],

                           "connecticut_sun":["tt":"https://twitter.com/ConnecticutSun", "ig":"https://www.instagram.com/connecticutsun/?hl=en", "fb":"https://www.facebook.com/connecticutsun/"],

                           "indiana_fever":["tt":"https://twitter.com/IndianaFever", "ig":"https://www.instagram.com/indianafever", "fb":"https://www.facebook.com/indianafever/"],

                           "new_york_liberty":["tt":"https://twitter.com/nyliberty", "ig":"", "fb":""],
  
                           "washington_mystics":["tt":"https://twitter.com/washmystics", "ig":"https://www.instagram.com/washmystics/", "fb":"https://www.facebook.com/WashingtonMystics/"],

                           "dallas_wings":["tt":"https://twitter.com/dallaswings", "ig":"https://www.instagram.com/dallaswings/", "fb":"https://www.facebook.com/dallaswings/"],
                           

                           "las_vegas_aces":["tt":"https://twitter.com/LVAces", "ig":"https://www.instagram.com/lvaces/?hl=en", "fb":"https://www.facebook.com/LVACES/"],
  
                           "los_angeles_sparks":["tt":"https://twitter.com/LA_Sparks", "ig":"https://www.instagram.com/la_sparks/", "fb":"https://www.facebook.com/losangelessparks/"],
                           
                           
                           "minnesota_lynx":["tt":"https://twitter.com/minnesotalynx", "ig":"https://www.instagram.com/minnesotalynx/", "fb":"https://www.facebook.com/minnesotalynx/"],
                           "phoenix_mercury":["tt":"https://twitter.com/phoenixmercury", "ig":"https://www.instagram.com/phoenixmercury/", "fb":"https://www.facebook.com/phoenixmercury/"],
                           "seattle_storm":["tt":"https://twitter.com/seattlestorm", "ig":"https://www.instagram.com/seattlestorm/", "fb":"https://www.facebook.com/seattlestorm/"]
  ]

  
  
  var fb = ""
  var twitter = ""
  var instagram = ""
  
  
  
  override func viewDidLoad() {
    
    //Didn't realize we had these as globals
    home_team_name = home
    away_team_name = away
    
    
    
    teamName = team_obj.teamName
    
    
    //Removed the underscore
    display_teamName = teamName.replacingOccurrences(of: "_", with: " ", options: NSString.CompareOptions.literal, range: nil)
    // Captialize first letter
    display_teamName = display_teamName.capitalizingFirstLetter()
    
    

    
    
    players = team_obj.playerList
    
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
    
   
      addSocialMedia()
    
    
    
    
  }
  
    
  func addSocialMedia(){
      var starting_x = 30
      var y = 300
      
  
    if (league == "WNBA") {
      fb = wnba_social_media[teamName]!["fb"]!
         twitter = wnba_social_media[teamName]!["tt"]!
           instagram = wnba_social_media[teamName]!["ig"]!
    }
      
      // Since only NWSL api has social media right now 
    else {
      fb = team_obj.fb
      instagram = team_obj.instagram
      twitter = team_obj.twitter
    }
   
    
    
    
    
    

      if (fb != "") {
        var button : UIButton
        button = UIButton()
         button.frame = CGRect(x: starting_x, y: y, width: 30, height: 30)
         button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

         button.setTitle("FB", for: UIControl.State.normal)
        
        
        let btnImage = UIImage(named: "facebook_logo")
        button.setImage(btnImage , for: UIControl.State.normal)

         
         button.addTarget(self, action: #selector(didTapFB), for: UIControl.Event.touchDown)
        
          mainView.addSubview(button)
        
          starting_x += 50
        
      }
      if (twitter != "") {
        var button : UIButton
        button = UIButton()
        button.frame = CGRect(x: starting_x, y: y, width: 30, height: 30)
         button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

         button.setTitle("TT", for: UIControl.State.normal)

         let btnImage = UIImage(named: "twitter_logo")
         button.setImage(btnImage , for: UIControl.State.normal)

         button.addTarget(self, action: #selector(didTapTT), for: UIControl.Event.touchDown)
        
          mainView.addSubview(button)
        
          starting_x += 50
        
      }
      if (instagram != "") {
        var button : UIButton
        button = UIButton()
        button.frame = CGRect(x: starting_x, y: y, width: 30, height: 30)
         button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)

         button.setTitle("IG", for: UIControl.State.normal)
         let btnImage = UIImage(named: "ig_logo")
              button.setImage(btnImage , for: UIControl.State.normal)
         button.addTarget(self, action: #selector(didTapIG), for: UIControl.Event.touchDown)
        
          mainView.addSubview(button)
        
          starting_x += 50
        
      }
      
      
      
      
      
    }
    
    @IBAction func didTapFB(sender: UIButton) {
      UIApplication.shared.openURL(NSURL(string: fb)! as URL)
  }
    
    @IBAction func didTapTT(sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: twitter)! as URL)
    }
    @IBAction func didTapIG(sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: instagram)! as URL)
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
    
    button.addTarget(self, action: #selector(segueBackButton), for: UIControl.Event.touchDown)
    
    
    
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
    
    explore_btn.addTarget(self, action: #selector(segueListTeams), for: UIControl.Event.touchDown)
    
    mainView.addSubview(explore_btn)
    

    let camera_btn = UIButton()
    imageName = "circle.png"
    image = UIImage(named: imageName)
    
    camera_btn.setImage(image, for: [])
    
    camera_btn.frame = CGRect(x: 89, y: 690, width: 197, height: 104)
    
    camera_btn.layer.zPosition = 1;
    
    camera_btn.addTarget(self, action: #selector(segueCamera), for: UIControl.Event.touchDown)
    
    mainView.addSubview(camera_btn)

    let app_btn = UIButton()
    imageName = "aperture.png"
    image = UIImage(named: imageName)

    app_btn.setImage(image, for: [])

    app_btn.frame = CGRect(x: 150, y: 707, width: 73, height: 71)

    app_btn.layer.zPosition = 1;

    app_btn.addTarget(self, action: #selector(segueCamera), for: UIControl.Event.touchDown)

    mainView.addSubview(app_btn)
    
//
//    var imageName_1 = "aperture.png"
//
//       var image_1 = UIImage(named: imageName_1)
//       var imageView = UIImageView(image: image_1!)
//
//
//       imageView.frame = CGRect(x: 150, y: 707, width: 73, height: 71)
//    imageView.layer.zPosition = 1
//       mainView.addSubview(imageView)

    mainView.addSubview(label)
    
    
  }
  
  
  @objc func segueCamera(sender: UIButton!) {
     let btn: UIButton = sender
     print(btn.titleLabel?.text)
     performSegue(withIdentifier: "Camera", sender: self)
   }
  
  
  
  @objc func segueHome(sender: UIButton!) {
      let btn: UIButton = sender
      print(btn.titleLabel?.text)
      performSegue(withIdentifier: "Home", sender: self)
    }
  
  @objc func segueBackButton(sender: UIButton!) {
    let btn: UIButton = sender
    print(btn.titleLabel?.text)
    
    
    if prev_page == "GameInfo" {
      performSegue(withIdentifier: "GameInfo", sender: self)
    }
    else if prev_page == "ListTeams" {
       performSegue(withIdentifier: "ListTeams", sender: self)
      
    }
  }
  
  @objc func segueListTeams(sender: UIButton!) {
      let btn: UIButton = sender
      print(btn.titleLabel?.text)
      performSegue(withIdentifier: "ListTeams", sender: self)
    }
  
  
  
  
  func addBackgroundImage() {
    var imageName:String!
    print(league)
    if league == "NWSL" {
      imageName = "nwsl_teaminfo_background.jpeg"
    }
    else {
     imageName = "wnba_teaminfo_background.jpeg"
    }

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
      button.setTitle(name + "\t\t\t\t\t\t\t\t" + "#" + playerNum[i] + "\n" + playerPosition[i], for: UIControl.State.normal)
      
      //button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5)
      
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

    
    label.textColor = UIColor.white
    label.numberOfLines = 1
    
    
   
      label.minimumScaleFactor=0.5;
    
    


    
    label.frame = CGRect(x: 190, y: 120, width: 180, height: 20)
    scrollView.addSubview(label)
    
    
    
    //  var team_obj = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", teamName: "", playerList: [])
    
    let team_data = UILabel()

 
    team_data.text = "Head Coach: " + team_obj.headCoach + "\n" + "Stadium: " + team_obj.stadium + "\nDate Founded: " + team_obj.dateFounded + "\nWins: " + team_obj.currentWins + "\nLosses: " + team_obj.currentLosses + "\nTies: " + team_obj.currentTies
    
    team_data.frame = CGRect(x: 190, y: 70, width: 180, height: 300)
    
     team_data.numberOfLines = 6
    
    team_data.textColor = UIColor.white
    
    
    
    team_data.adjustsFontSizeToFitWidth=true;
    scrollView.addSubview(team_data)
    
    
    
    
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
            displayVC.team_obj = team_obj
      displayVC.prev_page = prev_page
      
      
      
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
  if (segue.identifier == "Home") {
    let displayVC = segue.destination as! HomeViewController
    displayVC.chosenLeague = league
    
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
