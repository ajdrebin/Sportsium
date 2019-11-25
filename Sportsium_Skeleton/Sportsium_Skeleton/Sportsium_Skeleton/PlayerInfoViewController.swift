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
  var display_teamName = "orlando pride"
  
  var home_team_name:String!
  var away_team_name:String!
  
  var playerName = "Joanna Boyles"
  var playerNum = "25"
  var playerPos = "Midfielder"
  var button_text = "Joanna Boyles\t\t\t\t\t\t\t\t\t\t #25\nMidfielder"
  
  
  var monthDict:[Int:String] = [1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"December"]
  
  
  
  
  var player_obj = Player(firstName: "", lastName: "", instagram: "", hometown: "", twitter: "", number: "", snapchat: "", height: "", fb: "", DOB: "", country: "", playerId: 0, position: "")

  var team_obj = TeamInfo(cityLocation: "", league: "", dateFounded: "", instagram: "", currentWins: "", twitter: "", snapchat: "", currentTies: "", currentLosses: "", fb: "", headCoach: "", stadium: "", teamName: "", playerList: [])
  
  
  
  
  
  var fb = ""
  var twitter = ""
  var instagram = ""
  

  
  
  
  
  
  override func viewDidLoad() {
  
    print(player_obj)
    
    teamName = team_obj.teamName
    
    //Removed the underscore
    display_teamName = teamName.replacingOccurrences(of: "_", with: " ", options: NSString.CompareOptions.literal, range: nil)
    // Captialize first letter
    display_teamName = display_teamName.capitalizingFirstLetter()

    
    super.viewDidLoad()

    
    //initialize some things
    playerName = player_obj.firstName + " " + player_obj.lastName
    
    playerNum = player_obj.number
    playerPos = player_obj.position
    fb = player_obj.fb
    twitter = player_obj.twitter
    instagram = player_obj.instagram
    
    
 
    
    textView.isUserInteractionEnabled = false
    
    mainView.backgroundColor = UIColor.init(displayP3Red: 128/255, green: 196/255, blue: 249/255, alpha: 1)
    editNumberLabel()
    addTeamLogo()
  
    setPlayerName()
    makeTextView()
    addNavBar()
    makeBackButton()
    addSocialMedia()
    
  }
  
  
  func addSocialMedia(){
    var starting_x = 320
    var y = 230
    


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
      
        starting_x -= 50
      
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
      
        starting_x -= 50
      
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
      
        starting_x -= 50
      
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
  
  
  
  
  
  func makeTextView() {
    textView.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
    textView.clipsToBounds = true;
    textView.layer.cornerRadius = 10.0;

    
    
    let formattedString = NSMutableAttributedString()
    formattedString
        .bold("Bold Text")
        .normal(" Normal Text ")
        .bold("Bold Text")

    
    
    
    let player_dob =  player_obj.DOB.components(separatedBy: "-")
    
    var age:Int
    
    var num:Int
    var month:String
    var day:String
    var year:String
    
    
    if player_dob.isEmpty {
      month = String(Int.random(in: 1..<12))
      day = String(Int.random(in: 1..<30))
      year = String(Int.random(in: 1992..<1996))
      age = 2019 - Int(year)!
    }
    else{
       age = 2019 - Int(player_dob[2])!
       num = Int(player_dob[0])!
       month = monthDict[num]!
        day = player_dob[1]
        year = player_dob[2]
    }
    
    
  

     
    
    
    
    
    textView.text = "\n\n\nPOSITION: " + playerPos.uppercased() + "\n"
    textView.text +=  "AGE: " + String(age) + " (" + player_obj.DOB + ")\n"
    textView.text +=  "HEIGHT: " + player_obj.height + "\n"
    
    textView.text += "HOMETOWN: " + player_obj.hometown + ", " + player_obj.country + "\n\n"
    textView.text += "   Stats:\n\tGames Played 2019 Season: " + String(Int.random(in: 10..<30)) +
"\n\tScores: " + String(Int.random(in: 20..<35)) + "\n\tAssists: " + String(Int.random(in: 10..<20)) + "\n\tSaves: " + String(Int.random(in: 5..<20)) + "\n\tCards Given: " + String(Int.random(in: 1..<10)) + "\n"
    
    

    
    textView.text += " \n" + playerName + " (born " + month + " "
    textView.text += day + ", " + year + ") is an American soccer player who plays as a "
    textView.text += playerPos.lowercased() + " for " + display_teamName + " in the NWSL."
    
    textView.textAlignment = .left

    // textView.addCharacterSpacing(kernValue: 1.3)
    textView.setLineSpacing(lineSpacing: 5.0)
    
    textView.textColor = UIColor.init(displayP3Red: 50/255, green: 153/255, blue: 254/255, alpha: 1)
     
    
    
    

    
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
    // create tap gesture recognizer
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))

    // add it to the image view;
    teamLogo.addGestureRecognizer(tapGesture)
    // make sure imageView can be interacted with by user
    teamLogo.isUserInteractionEnabled = true
    
  }
  
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
//            print("Image Tapped")
            performSegue(withIdentifier: "TeamInfo", sender: self)
            //Here you can initiate your new ViewController

        }
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
    
    explore_btn.addTarget(self, action: #selector(segueListTeams), for: UIControl.Event.touchDown)
    
    explore_btn.layer.zPosition = 1;
    
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
    
    app_btn.frame = CGRect(x: 150, y: 707, width: 72, height: 71)
    
    app_btn.layer.zPosition = 1;
    
    app_btn.addTarget(self, action: #selector(segueCamera), for: UIControl.Event.touchDown)
    
    mainView.addSubview(app_btn)
    
    
    

    mainView.addSubview(label)
    
    
  }
  
  func makeBackButton() {
    var button : UIButton
    button = UIButton()
    // x, y, width, height
    var x = 0
    var y = 10
    button.frame = CGRect(x: -20, y: 60, width: 100, height: 40)
    button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
    button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 0)
    button.setTitle("< Back", for: UIControl.State.normal)
    
    button.addTarget(self, action: #selector(segueTeamInfo), for: UIControl.Event.touchDown)
    
    
    
    mainView.addSubview(button)
    
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
  
  @objc func segueTeamInfo(sender: UIButton!) {
    let btn: UIButton = sender
    print(btn.titleLabel?.text)
    performSegue(withIdentifier: "TeamInfo", sender: self)
  }
  
  @objc func segueListTeams(sender: UIButton!) {
    let btn: UIButton = sender
    print(btn.titleLabel?.text)
    performSegue(withIdentifier: "ListTeams", sender: self)
  }
  

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if(segue.identifier == "TeamInfo") {
              let displayVC = segue.destination as! TeamInfoViewController
              displayVC.home = team_obj
        displayVC.home_team_name = home_team_name
         displayVC.away_team_name = away_team_name

        

      }
  }

  
  
  
  
  
  
  
  
}


extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
      let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)

        return self
    }

    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)

        return self
    }
}


extension UITextView {
  //Source
//https://stackoverflow.com/questions/27535901/change-character-spacing-on-uilabel-within-interface-builder/27536438#27536438
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
      attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
  
  
  //Source
  // https://stackoverflow.com/questions/39158604/how-to-increase-line-spacing-in-uilabel-in-swift
  func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

      guard let labelText = self.text else { return }

      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = lineSpacing
      paragraphStyle.lineHeightMultiple = lineHeightMultiple

      let attributedString:NSMutableAttributedString
      if let labelattributedText = self.attributedText {
          attributedString = NSMutableAttributedString(attributedString: labelattributedText)
      } else {
          attributedString = NSMutableAttributedString(string: labelText)
      }

      // (Swift 4.2 and above) Line spacing attribute
      attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


      // (Swift 4.1 and 4.0) Line spacing attribute
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

      self.attributedText = attributedString
  }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}






