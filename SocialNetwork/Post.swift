//
//  Post.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 25/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _caption: String!
    private var _imgUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    private var _liked = false
    
    var caption: String { return _caption }
    var imgUrl: String { return _imgUrl }
    var likes: Int { return _likes}
    var postKey: String { return _postKey }
        
    init(caption: String, imgUrl: String, likes: Int) {
        
        self._caption = caption
        self._likes = likes
        self._imgUrl = imgUrl
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imgUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
        
    }
    
    func adjustLikes(liked: Bool) {
        if liked {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postRef.child("likes").setValue(_likes)
    }
    
    
}
