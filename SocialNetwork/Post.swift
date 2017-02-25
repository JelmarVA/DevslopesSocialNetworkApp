//
//  Post.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 25/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String!
    private var _imgUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    
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
        
    }
    
    
}
