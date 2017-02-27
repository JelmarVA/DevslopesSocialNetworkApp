//
//  FancyView.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 22/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class FancyView: UIView, DropShadow, RoundEdges {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addDropShadow()
        roundEdges(withRadius: 2.0)
    }
    
}
