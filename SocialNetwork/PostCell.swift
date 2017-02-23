//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 23/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}
