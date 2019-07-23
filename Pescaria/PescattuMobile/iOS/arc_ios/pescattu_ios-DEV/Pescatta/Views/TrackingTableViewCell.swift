//
//  TrackingTableViewCell.swift
//  Pescatta
//
//  Created by MacITBAM01 on 04/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class TrackingTableViewCell: UITableViewCell {
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
