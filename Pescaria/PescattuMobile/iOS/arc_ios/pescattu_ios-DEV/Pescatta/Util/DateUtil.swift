//
//  DateUtil.swift
//  Pescatta
//
//  Created by MacITBAM01 on 26/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class DateUtil {
    static func formateDateFrom(date:Double) -> String{
        let fdate = Date(timeIntervalSince1970: date/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        dateFormatter.timeZone = NSTimeZone() as TimeZone?
        return dateFormatter.string(from: fdate)
    }
}
