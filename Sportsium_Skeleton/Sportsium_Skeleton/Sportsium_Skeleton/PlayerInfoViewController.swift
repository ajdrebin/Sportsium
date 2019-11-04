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
  var playerPos = "Midfielder"
  var button_text = "Joanna Boyles\t\t\t\t\t\t\t\t\t\t #25\nMidfielder"
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    let full_arr = button_text.components(separatedBy: "\t")
    print(full_arr)
    playerName = full_arr[0] + " " + full_arr[1]
    
    let info_str = full_arr[10]
    let info_arr = info_str.components(separatedBy: "\n")
    playerNum = info_arr[0].replacingOccurrences(of: "#", with: "")
    playerPos = info_arr[1]
    
    textView.isUserInteractionEnabled = false
    
    mainView.backgroundColor = UIColor.init(displayP3Red: 128/255, green: 196/255, blue: 249/255, alpha: 1)
    editNumberLabel()
    addTeamLogo()
    
    setPlayerName()
    makeTextView()
    addNavBar()
    makeBackButton()
    
    
    
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

    
    textView.text = "\n\n\nPOSITION: " + playerPos.uppercased() + "\n"
    textView.text +=  "AGE: 23 (11-13-1995)\n"
    textView.text +=  "HEIGHT: 5'9\"\n"
    
    textView.text += "HOMETOWN: RALEIGH, NC\n\n"
    textView.text += "   Stats:\n\tGames player: 30\n\tScores: 17 \n\tAssists: 12\n\tSaves: 2\n\tCards Given: 5\n"
    
    

    textView.text += " \n" + playerName + "(born November 13, 1995) is an American soccer player who plays as a " + playerPos.lowercased() + " for Orlando Pride in the NWSL."
    
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
    
    camera_btn.frame = CGRect(x: 145, y: 710, width: 85, height: 85)
    
    camera_btn.layer.zPosition = 1;
    
    camera_btn.addTarget(self, action: #selector(segueCamera), for: UIControl.Event.touchDown)
    
    
    
    mainView.addSubview(camera_btn)

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






