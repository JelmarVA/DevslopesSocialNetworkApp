//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 22/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOutTapped(_ sender: UIButton) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: SHOW_SIGNIN, sender: sender)
    }

}
