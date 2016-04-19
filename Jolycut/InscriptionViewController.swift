//
//  InscriptionViewController.swift
//  JoliCut
//
//  Created by Charles SALVAN on 19/04/16.
//  Copyright © 2016 Vinod AROUMOUGAME. All rights reserved.
//

import UIKit


class InscriptionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Email: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var LastName: UITextField!
    @IBOutlet var FirstName: UITextField!
    
    @IBAction func Signup(sender: AnyObject) {
    }
    
    @IBAction func Back(sender: AnyObject) {
        performSegueWithIdentifier("BackToMenu", sender: self)
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let whitespace = NSCharacterSet.whitespaceCharacterSet()
        let range = Email.text!.rangeOfCharacterFromSet(whitespace)
        let range0 = Password.text!.rangeOfCharacterFromSet(whitespace)
        let range1 = LastName.text!.rangeOfCharacterFromSet(whitespace)
        let range2 = FirstName.text!.rangeOfCharacterFromSet(whitespace)
        if (Email.text == ("") || Password.text == (""))
        {
            let myAlert = UIAlertController(title: "Error", message: "Can't let empty field !", preferredStyle: UIAlertControllerStyle.Alert)
            let dismiss = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default){(ACTION) in print("Dismissed");}
            myAlert.addAction(dismiss)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return false
        }
        else if ((range != nil) && (range0 != nil) && (range1 != nil) && (range2 != nil)) {
            let myAlert = UIAlertController(title: "Error", message: "Login can't contain whitespace !", preferredStyle: UIAlertControllerStyle.Alert)
            let dismiss = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default){(ACTION) in print("spacefound");}
            myAlert.addAction(dismiss)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return false
        }
        else
        {
            let url:NSURL = NSURL(string: "http://92.222.74.85/api/signup/"+LastName.text!+"/"+FirstName.text!+"/"+Password.text!+"/"+Email.text!)!
            let session = NSURLSession.sharedSession()
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            let data = "data=Hi".dataUsingEncoding(NSUTF8StringEncoding)
            let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
                {(data,response,error) in
                    if (nil != response as? NSHTTPURLResponse) {
                        let httpResponse = response as? NSHTTPURLResponse
                        MyVariables.ErrorCode = httpResponse!.statusCode
                        if (httpResponse!.statusCode != 404) {
                            let urlContents = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
                            guard let _:NSString = urlContents else {
                                print("error")
                                return
                            }
                            MyVariables.data = urlContents
                            print(MyVariables.data)
                        }
                    }
                    else {
                        MyVariables.ErrorCode = 8
                    }
                    guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                        print("error")
                        return
                    }
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(dataString)
                }
            )
            while (MyVariables.ErrorCode != 404 || MyVariables.ErrorCode != 8)
            {
                task.resume()
                print(MyVariables.data)
                if (MyVariables.ErrorCode == 404)
                {
                    MyVariables.ErrorCode = 0
                    let myAlert = UIAlertController(title: "SUCCESS !", message: "Your inscription is Finished", preferredStyle: UIAlertControllerStyle.Alert)
                    myAlert.addAction(UIAlertAction(title:"Login Now !", style: .Default, handler:  {action in self.performSegueWithIdentifier("Connect", sender: self)}))
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    return true
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
}