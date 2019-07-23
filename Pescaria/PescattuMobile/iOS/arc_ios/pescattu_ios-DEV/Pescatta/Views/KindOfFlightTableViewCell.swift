//
//  KindOfFlightTableViewCell.swift
//  Pescatta
//
//  Created by MacITBAM01 on 16/08/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class KindOfFlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vRed: UIView!
    @IBOutlet weak var lbKindOfFlight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup_cell(kindOfFlight:String,indexPath:IndexPath, choosenFlightKind:Int){
        lbKindOfFlight.text = kindOfFlight
        if (indexPath.row == choosenFlightKind){
            self.contentView.backgroundColor = UIColor.init(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 0.54)
            vRed.isHidden = false
        }else{
            self.contentView.backgroundColor = UIColor.white
            vRed.isHidden = true
        }
    }

}
