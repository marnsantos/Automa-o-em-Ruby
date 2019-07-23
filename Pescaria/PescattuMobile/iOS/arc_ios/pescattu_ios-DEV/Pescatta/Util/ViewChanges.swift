//
//  ApplyCornerRound.swift
//  Pescatta
//
//  Created by MacITBAM01 on 18/07/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class ViewChanges{
    static func applyCornerRoundTo(button:UIButton) {
        button.layer.cornerRadius = 23
    }
    
    static func applyMinorCornerRoundTo(button:UIButton) {
        button.layer.cornerRadius = 13
    }
    
    static func applyShadowTo(view:UIView){
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1.8
        view.clipsToBounds = false
        view.layer.masksToBounds = false
    }
}
