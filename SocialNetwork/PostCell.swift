//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 23/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var likesRef: FIRDatabaseReference!
    var liked = false {
        didSet{
            if liked {
                likeImg.image = UIImage(named: "filled-heart")
            }else {
                likeImg.image = UIImage(named: "empty-heart")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imgUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024) { (data, error) in
                if error != nil {
                    print("JELMAR: Unable to donwload image from firebase storage")
                }else {
                    print("JELMAR: imagge downloaded from firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imgUrl as NSString)
                        }
                    }
                }
            }
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.liked = false
            }else {
                self.liked = true
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.liked = !self.liked
                self.post.adjustLikes(liked: self.liked)
                self.likesRef.setValue(self.liked)
            }else {
                self.liked = !self.liked
                self.post.adjustLikes(liked: self.liked)
                self.likesRef.removeValue()
            }
        })
    }
}
