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
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
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
                    print("JELMAR: imgage downloaded from firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imgUrl as NSString)
                        }
                    }
                }
            }
        }
        
    }
    
}
