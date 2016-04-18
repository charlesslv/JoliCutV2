//
//  ViewController.swift
//  Test
//
//  Created by Quentin LE GAL on 13/04/16.
//  Copyright © 2016 Quentin LE GAL. All rights reserved.
//

import UIKit

struct MyVariables {
    static var ErrorCode = 0
    static var data = NSString()
}
struct User  {
    static var bit = NSArray()
    static var ID = User.bit [1]
    static var Lastname = User.bit [2]
    static var Firstname = User.bit [3]
    static var Password = User.bit [4]
    static var Email = User.bit [5]
    static var Paytool = User.bit [6]
    static var Adress = User.bit [7]
    static var Telnumb = User.bit [8]
    static var Picture = User.bit [9]
    static var Type = User.bit [10]
    static var Latt = User.bit [11]
    static var Long = User.bit [12]
    static var Factures = User.bit [13]
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var button_entity: UIButton!
    @IBOutlet var login: UITextField!
    @IBOutlet var password: UITextField!
    @IBAction func button(sender: AnyObject) {
    }
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        let whitespace = NSCharacterSet.whitespaceCharacterSet()
        let range = login.text!.rangeOfCharacterFromSet(whitespace)
        if ( login.text == ("") || password.text == ("") )
        {
            let myAlert = UIAlertController(title: "Error", message: "Can't let empty field !", preferredStyle: UIAlertControllerStyle.Alert)
            let dismiss = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default){(ACTION) in print("Dismissed");}
            myAlert.addAction(dismiss)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return false
        }
        else if (range != nil) {
            let myAlert = UIAlertController(title: "Error", message: "Login can't contain whitespace !", preferredStyle: UIAlertControllerStyle.Alert)
            let dismiss = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default){(ACTION) in print("spacefound");}
            myAlert.addAction(dismiss)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return false
        }
        else
        {
            let url:NSURL = NSURL(string: "http://92.222.74.85/api/authenticate/"+login.text!+"/"+password.text!)!
            let session = NSURLSession.sharedSession()
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            
            let task = session.dataTaskWithRequest(request) {
                (let data, let response, let error) in
                if (nil != response as? NSHTTPURLResponse) {
                    let httpResponse = response as? NSHTTPURLResponse
                    if (httpResponse!.statusCode != 404) {
                        let urlContents = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
                        guard let _:NSString = urlContents else {
                            print("error")
                            return
                        }
                        MyVariables.data = urlContents
                    }
                    MyVariables.ErrorCode = httpResponse!.statusCode
                    print("Fin de recherche http :")
                    guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                        print("error")
                        return
                    }
                }
                else {
                    MyVariables.ErrorCode = 8
                }
            }
            while (MyVariables.ErrorCode != 200 || MyVariables.ErrorCode != 404 || MyVariables.ErrorCode != 8)
            {
                task.resume()
                if (MyVariables.ErrorCode == 200)
                {
                    //print("data!!!!!!!!!!")
                    //print(MyVariables.data)
                    print("element 1")
                    User.bit = MyVariables.data.componentsSeparatedByString(",")
                    print(User.Firstname)
                    print(User.Lastname)
                    MyVariables.ErrorCode = 0
                    return true
                }
                else if (MyVariables.ErrorCode == 404)
                {
                    MyVariables.ErrorCode = 0
                    let myAlert = UIAlertController(title: "Error", message: "Incorrect credentials", preferredStyle: UIAlertControllerStyle.Alert)
                    let dismiss = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default){(ACTION) in print("Wrong login");}
                    myAlert.addAction(dismiss)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    return false
                }
                else if (MyVariables.ErrorCode == 8)
                {
                    MyVariables.ErrorCode = 0
                    let myAlert = UIAlertController(title: "Error", message: "Can't connect to server", preferredStyle: UIAlertControllerStyle.Alert)
                    let dismiss = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default){(ACTION) in print("Server can't respond !");}
                    myAlert.addAction(dismiss)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    return false
                }
            }
        }
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    //Calls this function when the tap is recognized.
}

