//
//  OfferTableViewCell.swift
//  Pescatta
//
//  Created by Andrew Almeida Chaves do Vale on 02/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

protocol OffersButtonsDelegate{
    func add_product_to_cart(at index:IndexPath)
}

class OfferTableViewCell: UITableViewCell {
    @IBOutlet weak var lbOfferImage: UIImageView!
    @IBOutlet weak var lbOfferName: UILabel!
    @IBOutlet weak var tfPreco: UITextField!
    @IBOutlet weak var btAddToCart: UIButton!
    @IBOutlet weak var shadowView: UIView!
    var delegate:OffersButtonsDelegate!
    var indexPath:IndexPath!
    
    //MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewChanges.applyMinorCornerRoundTo(button: btAddToCart)
        ViewChanges.applyShadowTo(view: shadowView)
        shadowView.center = self.contentView.center
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Delegate methods
    @IBAction func add_product_to_cart(_ sender: UIButton) {
        self.delegate?.add_product_to_cart(at: indexPath)
    }
    
    //MARK: - Setup methods
    func setup_offer_cell(offer:OfferData, aatc:String, atc:String){
        tfPreco.text = CurrencyUtil.convertToCurrency(price: offer.pricePromotional!.amount! as NSNumber)
        setup_cell(offer: offer, aatc: aatc, atc: atc)
    }
    
    func setup_product_cell(offer:OfferData, aatc:String, atc:String){
        var tPrice:NSNumber!
        if (UserDataDAO.check_if_is_logged() == true) {
            if (UserDataDAO.check_if_is_transire_user()) {
                tPrice = offer.priceWholeSale! as NSNumber
            }else{
                tPrice = offer.priceApp! as NSNumber
            }
        } else {
            tPrice = offer.priceApp! as NSNumber
        }
        tfPreco.text = CurrencyUtil.convertToCurrency(price: tPrice)
        setup_cell(offer: offer, aatc: aatc, atc: atc)
    }
    
    private func setup_cell(offer:OfferData, aatc:String, atc:String){
        selectionStyle = UITableViewCellSelectionStyle.none
        lbOfferName.text = offer.name
        if (offer.imageList.count > 0){
            lbOfferImage.sd_setImage(with: URL(string: Routes.get_image_path(imageName: offer.imageList![0])))
            lbOfferImage.contentMode = UIViewContentMode.scaleAspectFill
        }else{
            lbOfferImage.image = UIImage.init(named: "placeholder-image")
            lbOfferImage.contentMode = UIViewContentMode.center
        }
        if arr_cart.contains(where: {$0.id == offer.id}) {
            btAddToCart.backgroundColor = UIColor.init(red: 199.0/255.0, green: 45.0/255.0, blue: 12.0/255.0, alpha: 1)
            btAddToCart.setTitleColor(UIColor.white, for: .normal)
            btAddToCart.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 12.0)
            btAddToCart.setTitle("REMOVER",for: .normal)
        } else{
            btAddToCart.backgroundColor  = UIColor.init(red: 25.0/255.0, green: 173.0/255.0, blue: 80.0/255.0, alpha: 1)
            btAddToCart.setTitleColor(UIColor.white, for: .normal)
            btAddToCart.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 12.0)
            btAddToCart.setTitle("ADICIONAR",for: .normal)
        }
    }
    
}
