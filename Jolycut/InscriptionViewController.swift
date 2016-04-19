//
//  InscriptionViewController.swift
//  JoliCut
//
//  Created by Charles SALVAN on 19/04/16.
//  Copyright © 2016 Vinod AROUMOUGAME. All rights reserved.
//

import UIKit


class InscriptionViewController: UIViewController, UITextFieldDelegate {
    
    func CloseKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let touch: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.CloseKeyboard))
        view.addGestureRecognizer(touch)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}