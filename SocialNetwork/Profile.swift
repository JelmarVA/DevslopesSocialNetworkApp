//
//  Profile.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 27/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import Foundation
import Firebase

class Profile {
    
    private var _uid: String?
    private var _name: String? { didSet {updateChild(DB_USER_NAME, withValue: _name ?? "")}}
    private var _imgUrl: String? { didSet {updateChild(DB_USER_IMG_URL, withValue: _imgUrl ?? "")}}
    private var _provider: String?
    private var _profileRef: FIRDatabaseReference!
    private var _posts = [String]()
    
    var uid: String { get { return _uid ?? "" } set { _uid = newValue }}
    var name: String { get { return _name ?? "Name not found" } set { _name = newValue } }
    var imgUrl: String? { get { return _imgUrl} set {_imgUrl = newValue }}
    var provider: String { get { return _provider ?? ""} set {_provider = newValue}}
    var profileReference: FIRDatabaseReference { get { return _profileRef } set {_profileRef = newValue}}
    var posts: [String] { get { return _posts } set { _posts = newValue }}
    
    
    init(withUid profileUid: String?, completion: @escaping (Bool) -> ()) {
        if let uid = profileUid {
            self.uid = uid
            profileReference = DataService.ds.REF_USERS.child(uid)
        }else {
            profileReference = DataService.ds.REF_USER_CURRENT
        }
        
        profileReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let profileDict = snapshot.value as? Dictionary<String, AnyObject> {
                print(profileDict)
                self.setDataToProfile(withData: profileDict)
            }
            completion(true)
        })
    }
        
    func setDataToProfile(withData data: Dictionary<String, AnyObject>) {
        if let name = data[DB_USER_NAME] as? String{
            self.name = name
        }
        
        if let imgUrl = data[DB_USER_IMG_URL] as? String {
            self.imgUrl = imgUrl
        }
        
        if let posts = data[DB_USER_POSTS] as? Dictionary<String, AnyObject> {
            for post in posts {
                self.posts.append(post.key)
            }
        }
        
        if let prov = data[DB_USER_PROVIDER] as? String {
            provider = prov
        }
        
    }
    
    func updateChild(_ child: String, withValue val: String) {
        let ref = profileReference.child(child)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                ref.setValue(val)
            }else {
                ref.removeValue()
                ref.setValue(val)
            }
        })
    }
}
