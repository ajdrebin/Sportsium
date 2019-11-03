//
//  TeamInfoViewController.swift
//  Sportsium
//
//  Created by Chia Chen on 10/21/19.
//  Copyright © 2019 Chia Chen. All rights reserved.
//

import UIKit

class TeamInfoViewController: UIViewController {
  
  
  //@IBOutlet var mainView: UIView!
  
  //@IBOutlet weak var scrollView: UIScrollView!
  
  
  

  
  
  
  @IBOutlet var mainView: UIView!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var innerView: UIView!
  
  @IBOutlet weak var innerViewHeight: NSLayoutConstraint!
  
  var playerArray = ["andy","ben","carol","steve","nick","james","mandy"]
  var playerNum = ["1","2","3","4","5","6","7"]
  
  var teamName = "orlando_pride"
  
  
  
  
  @IBOutlet weak var nav_label: UILabel!
  
  

  override func viewDidLoad() {
    var scrollHeight = 400 + 100 * playerArray.count
    innerViewHeight.constant = CGFloat(scrollHeight)

        
    
  
    nav_label.frame = CGRect(x: 0, y: 20, width: scrollView.frame.width, height: 300)
         
    mainView.addSubview(nav_label)
    
    
    
    
    
    
    super.viewDidLoad()
    
   
    
    //scrollView.contentInsetAdjustmentBehavior = .automatic
scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never

    
    
    
    
 

//
    
    


    
  
    makeButtons()
    addBackgroundImage()
    addTeamLogo()
    playerLabel()
    addTeamNameLabel()
    
    
  }
  
  
  func addBackgroundImage() {
    var imageName = "teaminfo_background.jpeg"
    print(imageName)
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
      button.frame = CGRect(x: x, y: y, width: scrollView.frame.width, height: 100.0)
      if i % 2 == 0 {
        button.backgroundColor = UIColor.init(displayP3Red: 221/255, green: 240/255, blue: 1, alpha: 1)
      }
      else{
        button.backgroundColor = UIColor.white
      }
      
      button.setTitleColor(UIColor.init(displayP3Red: 11/255, green: 96/255, blue: 168/255, alpha: 1), for: UIControl.State.normal)
      
      //Allow for multi line text \n separated.
      button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
      button.setTitle(name + "\t\t\t\t\t\t\t\t\t\t " + "#" + playerNum[i] + "\nMidfielder", for: UIControl.State.normal)
      

      
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
    label.text = teamName.uppercased()
    label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
    
    label.adjustsFontForContentSizeCategory = true
    
    
    label.font = label.font.withSize(20)
    label.textColor = UIColor.white
    label.numberOfLines = 0
    
    label.frame = CGRect(x: 200, y: 120, width: scrollView.frame.width, height: 20)
    scrollView.addSubview(label)
  }
  
  
  
  @objc func buttonAction(sender: UIButton!) {
    let btn: UIButton = sender
    print(btn.titleLabel?.text)
    performSegue(withIdentifier: "PlayerInfo", sender: self)
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
