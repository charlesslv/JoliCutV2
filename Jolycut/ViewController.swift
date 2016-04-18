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
}

class ViewController: UIViewController {
    
    
    @IBOutlet var button_entity: UIButton!
    @IBOutlet var login: UITextField!
    @IBOutlet var password: UITextField!
    @IBAction func button(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    MyVariables.ErrorCode = httpResponse!.statusCode
                    print("Fin de recherche http :")
                    print(MyVariables.ErrorCode)
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
                print("Before task.resume")
                print(MyVariables.ErrorCode)
                task.resume()
                print("After task.resume")
                print(MyVariables.ErrorCode)
                if (MyVariables.ErrorCode == 200)
                {
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
        /*override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
         if (segue.identifier == "segueTest") {
         let svc = segue!.destinationViewController as! secondViewController;
         svc.toLog = login.text
         svc.toPass = password.text
         }*/
        }
        return false
    }
}

