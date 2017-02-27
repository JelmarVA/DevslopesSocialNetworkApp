//
//  EnabledDisabledField.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 26/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class EnabledDisabledField: FancyField, DropShadow {
    
    override var isEnabled: Bool {
        didSet{
            if isEnabled {
                layer.backgroundColor = UIColor.white.cgColor
                addDropShadow()
            }else {
                layer.backgroundColor = UIColor.clear.cgColor
                removeDropShadow()
            }
        }
    }
    
}
