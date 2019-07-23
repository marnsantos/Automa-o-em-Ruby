//
//  PlaceHolderMessageUtil.swift
//  Pescatta
//
//  Created by MacITBAM01 on 25/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class PlaceHolderMessage: NSObject {
    
    static var phMessage:UILabel? = nil
    
    static func showPlacheholderMessage(message:String, view:UIView,verticalBias:Float) {

        if phMessage != nil {
            phMessage?.removeFromSuperview()
        }
        phMessage = UILabel()
        phMessage!.textAlignment = .center
        phMessage!.numberOfLines = 3
        phMessage!.font =  UIFont.systemFont(ofSize: 20.0)
        phMessage!.textColor = UIColor.init(red: 102.0/255.0, green: 0, blue: 0, alpha: 1)
        view.addSubview(phMessage!)
        phMessage!.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: phMessage!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: phMessage!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: CGFloat(verticalBias), constant: 0)
        let widthConstraint = NSLayoutConstraint(item: phMessage!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 0.6, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: phMessage!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        phMessage!.text = message
    }
    
}
