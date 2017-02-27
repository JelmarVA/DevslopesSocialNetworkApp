//
//  RoundButton.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 22/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class RoundButton: UIButton, RoundEdges, DropShadow {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addDropShadow()
        imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeCircle()
    }
    
    

}
