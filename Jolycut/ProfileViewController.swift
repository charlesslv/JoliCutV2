//
//  ProfileViewController.swift
//  JoliCut
//
//  Created by Quentin LE GAL on 19/04/16.
//  Copyright © 2016 Vinod AROUMOUGAME. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Quit(sender: AnyObject) {
        performSegueWithIdentifier("Quit", sender: self)
    }
    
}