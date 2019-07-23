//
//  MenuItemTableViewCell.swift
//  Pescatta
//
//  Created by Andrew Almeida Chaves do Vale on 01/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet weak var ivMenuItem: UIImageView!
    @IBOutlet weak var lbMenuItem: UILabel!
    
    //MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup methods
    func setup_cell(mItem:String, mItemImage:String) {
        lbMenuItem.text  = mItem
        ivMenuItem.image = UIImage.init(named: mItemImage)
    }
    
}
