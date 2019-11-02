//
//  CameraViewController.swift
//  test_multi_ui
//
//  Created by Alina Drebin on 10/31/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    // A wrapper that can be used to control the camera.  Any frame
    // pre-processing, however, needs to be done in the wrapper's
    // processImage() delegate method in this implementation.
    var videoCameraWrapper : CvVideoCameraWrapper!
    
    
    
    
    @IBAction func HelpButton(_ sender: UIButton) {
        self.view.addSubview(Popover)
        Popover.center = self.view.center
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        self.Popover.removeFromSuperview()
    }
    
    @IBOutlet var Popover: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    /// Start camera.
    @IBAction func actionStart(sender: AnyObject) {
        self.videoCameraWrapper.startCamera()
    }
    
    /// Stop camera.
    @IBAction func actionStop(sender: AnyObject) {
        self.videoCameraWrapper.stopCamera()
    }
    
    /** Initialize the wrapper with this controller's image view to display
     * camera output in it, pre-processed by the delegate's processImage()
     * method.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(Popover)
        Popover.center = self.view.center
        self.Popover.layer.cornerRadius = 10
        self.videoCameraWrapper = CvVideoCameraWrapper(imageView:imageView)

        // This is not essential...
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3
    }
    @IBOutlet weak var home: UIImageView!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var listTeams: UIImageView!
}
