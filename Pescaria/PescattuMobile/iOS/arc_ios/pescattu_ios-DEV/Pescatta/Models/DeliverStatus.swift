//
//  DeliverStatus.swift
//  Pescatta
//
//  Created by MacITBAM01 on 04/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class DeliverStatus: NSObject {
    var status:String!
    var date:String!
    
    init(status:String,date:String) {
        self.status = status
        self.date = date
    }
}
