//
//  CustomerMenuTableViewController.swift
//  FoodTaskerMobile
//
//  Created by William Setiono on 14/01/19.
//  Copyright © 2019 William Setiono. All rights reserved.
//

import UIKit

class CustomerMenuTableViewController: UITableViewController {

    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbName.text = User.currentUser.name
        
        imgAvatar.image = try! UIImage(data: Data(contentsOf: URL(string: User.currentUser.pictureURL!)!))
        imgAvatar.layer.cornerRadius = 70 / 2
        imgAvatar.layer.borderWidth = 1.0
        imgAvatar.layer.borderColor = UIColor.white.cgColor
        imgAvatar.clipsToBounds = true
        
        view.backgroundColor = UIColor(red: 0.19, green: 0.18, blue: 0.31, alpha: 1.0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CustomerLogout" {
            
            FBManager.shared.logOut()
            User.currentUser.resetInfo()
            
        }
    }

}
