//
//  RoundView.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 26/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class RoundView: UIView, RoundEdges, DropShadow {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeCircle()
        addDropShadow()
    }

}
