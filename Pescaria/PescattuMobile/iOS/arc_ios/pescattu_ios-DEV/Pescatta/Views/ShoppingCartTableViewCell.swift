//
//  ShoppingCartTableViewCell.swift
//  Pescatta
//
//  Created by Andrew Almeida Chaves do Vale on 02/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

protocol CartsButtonsDelegate{
    func decrease_quantity(at index:IndexPath)
    func increase_quantity(at index:IndexPath)
}

class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    @IBOutlet weak var lbTotalItemPrice: UILabel!
    var delegate:CartsButtonsDelegate!
    var indexPath:IndexPath!
    
    //MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
        lbQuantity.layer.borderWidth = 1.0
        lbQuantity.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup methods
    func setup_cell(offer:OfferData){
        lbProductName.text = offer.name ?? ""
        lbQuantity.text    = "\(offer.quantity ?? 0)"
        if (offer.imageList.count > 0){
            ivProduct.sd_setImage(with: URL(string: Routes.get_image_path(imageName: offer.imageList![0])))
            ivProduct.contentMode = UIViewContentMode.scaleAspectFill
        }else{
            ivProduct.image = UIImage.init(named: "placeholder-image")
            ivProduct.contentMode = UIViewContentMode.center
        }
        if (offer.isPromotional == 0) {
            var tPrice:NSNumber!
            if UserDataDAO.check_if_is_logged() == true {
                if (UserDataDAO.check_if_is_transire_user()){
                    tPrice = offer.priceWholeSale! as NSNumber
                }else{
                    tPrice = offer.priceApp! as NSNumber
                }
            } else {
                tPrice = offer.priceApp! as NSNumber
            }
            lbTotalItemPrice.text = CurrencyUtil.convertToCurrency(price: (Float(offer.quantity!) * (tPrice as! Float)) as NSNumber)
        } else{
            lbTotalItemPrice.text = CurrencyUtil.convertToCurrency(price: Float(offer.quantity!) * (offer.pricePromotional?.amount)! as NSNumber)
        }
    }

    @IBAction func decrease_quantity(_ sender: UIButton) {
        self.delegate?.decrease_quantity(at: indexPath)
    }
    
    @IBAction func increase_quantity(_ sender: UIButton) {
        self.delegate?.increase_quantity(at: indexPath)
    }
}
