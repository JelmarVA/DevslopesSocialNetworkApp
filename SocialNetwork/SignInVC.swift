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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("JELMAR: ID found in keychain")
            performSegue(withIdentifier: SHOW_FEED, sender: nil)
        }
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
                    if let user = user {
                        let userData = [DB_USER_PROVIDER: user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd) { (user, error) in
                        if error != nil{
                            print("JELMAR: Unable to auth with Firebase email")
                        } else {
                            print("JELMAR: Succesfully auth with Firebase")
                            if let user = user {
                                let userData = [DB_USER_PROVIDER: user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
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
                if let user = user {
                    let userData = [DB_USER_PROVIDER: credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String,String>){
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainRes = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JELMAR: Data saved to keychain \(keychainRes)")
        performSegue(withIdentifier: SHOW_FEED, sender: nil)
    }
}

