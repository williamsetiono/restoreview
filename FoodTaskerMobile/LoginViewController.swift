//
//  LoginViewController.swift
//  FoodTaskerMobile
//
//  Created by William Setiono on 14/01/19.
//  Copyright © 2019 William Setiono. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var bLogin: UIButton!
    @IBOutlet weak var bLogout: UIButton!
    
    var fbLoginSuccess = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if (FBSDKAccessToken.current() != nil) {
            
            bLogout.isHidden = false
            FBManager.getFBUserData(completionHandler: {
                
                self.bLogin.setTitle("Continue as \(User.currentUser.email!)", for: .normal)
                //self.bLogin.sizeToFit()
            })
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true) {
            performSegue(withIdentifier: "CustomerView", sender: self)
        }
    }
    
    @IBAction func facebookLogout(_ sender: Any) {
        
        FBManager.shared.logOut()
        User.currentUser.resetInfo()
        
        bLogout.isHidden = true
        bLogin.setTitle("Login with Facebook", for: .normal)

    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        
        if (FBSDKAccessToken.current() != nil) {
            
            fbLoginSuccess = true
            self.viewDidAppear(true)
            
        } else {
            
            FBManager.shared.logIn(
                withReadPermissions: ["public_profile","email"],
                from: self,
                handler: { (result, error) in
                
                    if (error == nil) {
                        
                        FBManager.getFBUserData(completionHandler: {
                            self.fbLoginSuccess = true
                            self.viewDidAppear(true)
                        })
                    }
            })
        }
    
    }
}
