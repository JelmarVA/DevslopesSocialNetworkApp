//
//  CircleView.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 23/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class CircleView: UIImageView, RoundEdges {
    
    override func layoutSubviews() {
        makeCircle()
    }

}
