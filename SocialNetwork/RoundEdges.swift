//
//  RoundEdges.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 26/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

protocol RoundEdges {}

extension RoundEdges where Self: UIView {
    
    func makeCircle(){
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
    func roundEdges(withRadius radius: CGFloat){
        layer.cornerRadius = radius
    }
}
