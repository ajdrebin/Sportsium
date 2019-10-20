//
//  ViewController.swift
//  ML-test
//
//  Created by Alina Drebin on 10/20/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(OpenCVWrapper.openCVVersionString())")
        let openCVWrapper = OpenCVWrapper()
        openCVWrapper.isThisWorking()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

