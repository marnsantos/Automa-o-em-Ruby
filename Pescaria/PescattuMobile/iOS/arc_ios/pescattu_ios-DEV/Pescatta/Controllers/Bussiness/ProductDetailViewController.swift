//
//  ProductDetailViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 29/05/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import GMStepper

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageCarousel: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbProductPrice: UILabel!
    @IBOutlet weak var lbProductDescription: UITextView!
    @IBOutlet weak var stQuantity: GMStepper!
    @IBOutlet weak var btAddToCart: UIButton!
    @IBOutlet weak var bbCart2: UIBarButtonItem!
    
    var offer:OfferData!
    var isPromotional:Bool!
    
    override func viewDidLayoutSubviews() {
        bbCart2.addBadge(text: "\(arr_cart.count)")
        if (offer.imageList.count > 0){
            var x:CGFloat = 0
            for image in offer.imageList {
                let prodImageView = UIImageView(frame: imageCarousel.frame)
                prodImageView.sd_setImage(with: URL(string: Routes.get_image_path(imageName: image)), completed: nil)
                prodImageView.contentMode = .scaleAspectFill
                prodImageView.frame.origin.x = imageCarousel.frame.width * x
                prodImageView.clipsToBounds = true
                imageCarousel.addSubview(prodImageView)
                x = x + 1
            }
            imageCarousel.contentSize.width = imageCarousel.frame.size.width * CGFloat(offer.imageList.count)
        }else{
            let prodImageView = UIImageView(frame: imageCarousel.frame)
            prodImageView.image = UIImage(named: "placeholder-image")
            prodImageView.contentMode = .center
            imageCarousel.addSubview(prodImageView)
        }
        configurePageControl()
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        add_or_remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCarousel.delegate = self
        ViewChanges.applyCornerRoundTo(button: btAddToCart)
        lbProductName.text = offer.name
        let tPrice:NSNumber
        if UserDataDAO.check_if_is_logged() == true {
            if isPromotional {
                tPrice = offer.pricePromotional!.amount as NSNumber
            }else {
                if (UserDataDAO.check_if_is_transire_user()) {
                    tPrice = offer.priceWholeSale! as NSNumber
                } else{
                    tPrice = offer.priceApp! as NSNumber
                }
            }
        } else {
            if isPromotional {
                tPrice = offer.pricePromotional!.amount as NSNumber
            } else{
                tPrice = offer.priceApp! as NSNumber
            }
        }
        lbProductPrice.text = CurrencyUtil.convertToCurrency(price: tPrice)
        lbProductDescription.text = offer.descriptionn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Bussiness methods
    @IBAction func add_to_cart(_ sender: Any) {
        if (!arr_cart.contains(where: {$0.id == self.offer!.id})){
            let off:OfferData = self.offer
            off.quantity = Int(stQuantity.value)
            if isPromotional {
                offer.isPromotional = 1
            }else{
                off.isPromotional = 0
            }
            arr_cart.append(off)
        }else{
            arr_cart = arr_cart.filter() { $0.cod != self.offer.cod }
        }
        bbCart2.addBadge(text: "\(arr_cart.count)")
        add_or_remove()
    }
    
    func add_or_remove(){
        if arr_cart.contains(where: {$0.id == offer.id}) {
            btAddToCart.layer.borderWidth = 0.0
            btAddToCart.backgroundColor = UIColor.init(red: 199.0/255.0, green: 45.0/255.0, blue: 12.0/255.0, alpha: 1)
            btAddToCart.setTitleColor(UIColor.white, for: .normal)
            btAddToCart.setTitle("REMOVER DO CARRINHO", for: .normal)
            stQuantity.isHidden = true
        } else{
            btAddToCart.layer.borderWidth = 1.0
            btAddToCart.layer.borderColor = UIColor.init(red: 25.0/255.0, green: 173.0/255.0, blue: 80.0/255.0, alpha: 1).cgColor
            btAddToCart.backgroundColor = UIColor.white
            btAddToCart.setTitleColor(UIColor.init(red: 25.0/255.0, green: 173.0/255.0, blue: 80.0/255.0, alpha: 1),for: .normal)
            btAddToCart.setTitle("ADICIONAR AO CARRINHO", for: .normal)
            stQuantity.isHidden = false
        }
    }
    
    @IBAction func go_to_shooping_cart(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let shopping_cart_vc:ShoppingCartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shopping_cart_vc") as! ShoppingCartViewController
        self.navigationController?.pushViewController(shopping_cart_vc, animated: true)
    }
    
    // MARK : Page control methods
    func configurePageControl() {
        self.pageControl.numberOfPages = offer.imageList.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * imageCarousel.frame.size.width
        imageCarousel.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
