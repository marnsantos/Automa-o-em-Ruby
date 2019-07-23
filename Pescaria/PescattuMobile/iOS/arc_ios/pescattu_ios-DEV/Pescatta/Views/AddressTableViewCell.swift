//
//  AddressTableViewCell.swift
//  Pescatta
//
//  Created by MacITBAM01 on 08/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var vRed: UIView!
    var indexPath:IndexPath!
    
    //MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup methods
    func setup_cell(address:AddressData, choosenAddress:Int){
        if (indexPath.section == choosenAddress){
            self.contentView.backgroundColor = UIColor.init(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 0.54)
            vRed.isHidden = false
        }else{
            self.contentView.backgroundColor = UIColor.white
            vRed.isHidden = true
        }
        lbAddress.text = "\(address.street ?? ""), \(address.number ?? ""), CEP: \(address.cep ?? "")"
    }
    
}
