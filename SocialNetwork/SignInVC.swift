//
//  SignInVC.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 22/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButtonTapped(_ sender: RoundButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("JELMAR: Unable to auth with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("JELMAR: User cancelled Facebook auth")
            }else {
                print("JELMAR: Succesfully auth with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: FancyButton) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd) { (user, error) in
                if error == nil {
                    print("JELMAR: Email user auth with firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd) { (user, error) in
                        if error != nil{
                            print("JELMAR: Unable to auth with Firebase email")
                        } else {
                            print("JELMAR: Succesfully auth with Firebase")
                        }
                    }
                }
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil {
                print("JELMAR: Unable to aut with Firebase - \(error)")
            }else {
                print("JELMAR: Succesfully authenticated with Firebase")
            }
        }
    }
    
}

