//
//  OrderTableViewCell.swift
//  Pescatta
//
//  Created by MacITBAM01 on 07/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var lbOrderNumber: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    //MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius  = 10
        self.contentView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup methods
    func setup_cell(order:OrderData,o:String,i:String){
        lbOrderNumber.text = "\(o) \(order.orderId  ?? -1)"
        lbStatus.text      = "\(order.status ?? "") \(i) \(DateUtil.formateDateFrom(date: order.odate!))"
    }
    
}
