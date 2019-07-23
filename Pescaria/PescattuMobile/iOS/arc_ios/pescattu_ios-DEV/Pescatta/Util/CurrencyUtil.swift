//
//  CurrencyUtil.swift
//  Pescatta
//
//  Created by MacITBAM01 on 25/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class CurrencyUtil {
    
    static func convertToCurrency(price:NSNumber) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if var formattedTipAmount = formatter.string(from: price) {
            formattedTipAmount = formattedTipAmount.replacingOccurrences(of: "$", with: "$ ")
            return "\(formattedTipAmount)"
        }
        return ""
    }

}
