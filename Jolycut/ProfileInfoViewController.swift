
//
//  ProfileInfoViewController.swift
//  JoliCut
//
//  Created by Quentin LE GAL on 19/04/16.
//  Copyright © 2016 Vinod AROUMOUGAME. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController {
    
    @IBOutlet var nom: UITextField!
    @IBOutlet var prenom: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var adresse: UITextField!
    @IBOutlet var tel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nom.text = (User.Lastname as String)
        prenom.text = (User.Firstname as String)
        email.text = (User.Email as String)
        adresse.text = (User.Adress as String)
        tel.text = (User.Telnumb as String)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Back(sender: AnyObject) {
        performSegueWithIdentifier("Back", sender: self)
    }
}