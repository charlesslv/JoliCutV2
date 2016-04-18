//
//  JolicutViewController.swift
//  JoliCut
//
//  Created by Vinod AROUMOUGAME on 18/04/16.
//  Copyright © 2016 Vinod AROUMOUGAME. All rights reserved.
//

import UIKit

class JolicutViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var jolicut_t: UILabel!
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var connexion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jolicut_t.alpha = 0.0
        self.create.alpha = 0.0
        self.connexion.alpha = 0.0
        
        UIView.animateWithDuration(2, delay: 0.0, options: .CurveEaseInOut, animations:
            {
                self.logo.frame = CGRect(x: 50, y: 400, width: 300, height: 375)
                self.jolicut_t.alpha = 1.0
                
            }, completion: { finished in })
        
        UIView.animateWithDuration(2, delay: 2.0, options: .CurveEaseInOut, animations:
            {
                self.create.alpha = 1.0
                self.connexion.alpha = 1.0
            }, completion: { finished in })
    }
    
}
