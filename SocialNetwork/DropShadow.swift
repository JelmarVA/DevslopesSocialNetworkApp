//
//  DropShadow.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 26/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit


protocol DropShadow {}

extension DropShadow where Self: UIView {
    func addDropShadow() {
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    func removeDropShadow() {
        layer.shadowOpacity = 0.0
    }
}
