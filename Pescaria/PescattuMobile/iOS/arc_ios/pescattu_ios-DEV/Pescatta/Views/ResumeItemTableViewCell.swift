//
//  PackageItemTableViewCell.swift
//  Pescatta
//
//  Created by MacITBAM01 on 16/08/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class ResumeItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell (description:String, price:Float){
        self.lbDescription.text = description
        self.lbPrice.text = CurrencyUtil.convertToCurrency(price: price as NSNumber)
    }

}
