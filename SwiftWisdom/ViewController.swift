//
//  ViewController.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 11/10/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        After(0.25) {
            print("Hi")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

