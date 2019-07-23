 //
//  OffersViewController.swift
//  Pescatta
//
//  Created by Andrew Almeida Chaves do Vale on 01/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SWSegmentedControl

class OffersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, OffersButtonsDelegate, SWSegmentedControlDelegate {
    
    @IBOutlet weak var tbHeaderView: UIView!
    @IBOutlet weak var tbMenuLeadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var tbMenuHeaderLeadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var tbMenu: UITableView!
    @IBOutlet weak var tbOffers: UITableView!
    @IBOutlet weak var bbCart: UIBarButtonItem!
    @IBOutlet weak var lbCostumerName: UILabel!
    @IBOutlet weak var tabHolderView: UIView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var isMenuOpen:Int!
    var arrMenuItens = [String]()
    var arrMenuItensImage = [String]()
    var offers:Offers?
    var isPromotional:Bool!
    var sc2:SWSegmentedControl!

    // MARK: - Life cicle methods
    override func viewDidLayoutSubviews() {
        bbCart.addBadge(text: "\(arr_cart.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if sc2 != nil {
            if  sc2.selectedSegmentIndex == 0 {
                download_offers()
            }else {
                download_products()
            }
        }
        if (UserDataDAO.check_if_is_logged() == false){
            arrMenuItens      = ["Login"]
            arrMenuItensImage = ["login"]
            tbMenu.reloadData()
        }else{
            APIClient.refresh_token { response in
                switch response.result {
                case .success(let user):
                    if response.response?.statusCode == 200 {
                        let token = user.data!.token!
                        UserDataDAO.save_refreshed_user_token(userToken: token)
                        if (UserDataDAO.check_if_is_social_media_user()){
                            self.arrMenuItens = ["Meus pedidos", "Meu carrinho","Fale conosco","Logout"]
                            self.arrMenuItensImage = ["my_orders","my_cart","fale_conosco","login"]
                        }else{
                            self.arrMenuItens = ["Meus pedidos", "Meu carrinho","Fale conosco","Alterar senha","Logout"]
                            self.arrMenuItensImage = ["my_orders","my_cart","fale_conosco","person","login"]
                        }
                        self.tbMenu.reloadData()
                    }else {
                        self.view.makeToast(user.errors![0], duration: 1.0, position: .center)
                        self.really_logout()
                    }
                    break
                    
                case .failure(let error):
                    self.view.makeToast("Seu token de acesso expirou.", duration: 1.0, position: .center)
                    self.really_logout()
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDataDAO.check_if_is_logged() {
            let name:String = UserDataDAO.get_user_name()
            lbCostumerName.text = name
            lbEmail.isHidden = false
            lbEmail.text = UserDataDAO.get_user_email()
        }
        isMenuOpen = 0
        tbMenu.delegate = self
        tbMenu.dataSource = self
        tbOffers.delegate = self
        tbOffers.dataSource = self
        searchBar.delegate = self
        bbCart.addBadge(text: "\(arr_cart.count)")
        searchBar.backgroundImage = UIImage()
        sc2 = SWSegmentedControl(items: ["OFERTAS", "PRODUTOS"])
        sc2.selectedSegmentIndex = 0
        sc2.translatesAutoresizingMaskIntoConstraints = false
        sc2.titleColor = UIColor.white
        sc2.unselectedTitleColor = UIColor.init(red: 154.0/255.0, green: 27.0/255.0, blue: 0, alpha: 1)
        sc2.font = UIFont.boldSystemFont(ofSize: 14.0)
        sc2.indicatorColor = UIColor.white
        tabHolderView.addSubview(sc2)
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sc2]|", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activate(constraints)
        let constraints2 = NSLayoutConstraint.constraints(withVisualFormat: "V:[sc2(44)]", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activate(constraints2)
        let centerY = NSLayoutConstraint(item: sc2, attribute: .centerY, relatedBy: .equal, toItem: tabHolderView, attribute: .centerY, multiplier: 1, constant: 0)
        tabHolderView.addConstraint(centerY)
        sc2.delegate = self
        ViewChanges.applyShadowTo(view: tbMenu)
        ViewChanges.applyShadowTo(view: tbHeaderView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Rest methods
    func download_offers(){
        isPromotional = true
        self.offers = nil
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
        APIClient.download_offers { response in
            switch response.result {
            case .success (let offers):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                if response.response?.statusCode == 200 {
                    self.offers = offers
                    self.tbOffers.reloadData()
                }else {
                    if self.offers != nil {
                        PlaceHolderMessage.showPlacheholderMessage(message:(self.offers?.errors?[0])!,view: self.tbOffers,verticalBias: 1.0)
                    }else {
                        PlaceHolderMessage.showPlacheholderMessage(message:"Sem conexão",view: self.tbOffers,verticalBias: 1.0)
                    }
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                PlaceHolderMessage.showPlacheholderMessage(message:"Nenhuma promoção a ser exibida. Verifique sua conexão.",view: self.tbOffers,verticalBias: 1.0)
                self.tbOffers.reloadData()
                print(error)
            }
        }
    }
    
    func download_products(){
        isPromotional = false
        self.offers = nil
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
        APIClient.download_products{ response in
            switch response.result {
            case .success(let offers):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                if response.response?.statusCode == 200 {
                    self.offers = offers
                    self.tbOffers.reloadData()
                }else {
                    if self.offers != nil {
                        PlaceHolderMessage.showPlacheholderMessage(message:(self.offers?.errors?[0])!,view: self.tbOffers,verticalBias: 1.0)
                    }else{
                        PlaceHolderMessage.showPlacheholderMessage(message:"Sem conexão",view: self.tbOffers,verticalBias: 1.0)
                    }
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                PlaceHolderMessage.showPlacheholderMessage(message:"Nenhum produto a ser exibido. Verifique sua conexão.",view: self.tbOffers,verticalBias: 1.0)
                self.tbOffers.reloadData()
                print(error)
            }
        }
    }
    
    func search_products(term:String){
        self.offers = nil
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
        APIClient.search_products(term: term) { response in
            switch response.result {
            case .success(let offers):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                if response.response?.statusCode == 200 {
                    self.offers = offers
                    self.tbOffers.reloadData()
                }else {
                    PlaceHolderMessage.showPlacheholderMessage(message:(self.offers?.errors?[0])!,view: self.tbOffers,verticalBias: 1.0)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                PlaceHolderMessage.showPlacheholderMessage(message:"Nenhum produto a ser exibido. Verifique sua conexão.",view: self.tbOffers,verticalBias: 1.0)
                self.tbOffers.reloadData()
                print(error)
            }
        }
    }
    
    func search_offers(term:String){
        self.offers = nil
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
        APIClient.search_offers(term: term) { response in
            switch response.result {
            case .success(let offers):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                if response.response?.statusCode == 200 {
                    self.offers = offers
                    self.tbOffers.reloadData()
                }else {
                    PlaceHolderMessage.showPlacheholderMessage(message:(self.offers?.errors?[0])!,view: self.tbOffers,verticalBias: 1.0)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                PlaceHolderMessage.showPlacheholderMessage(message:"Nenhuma promoção a ser exibida. Verifique sua conexão.",view: self.tbOffers,verticalBias: 1.0)
                self.tbOffers.reloadData()
                print(error)
            }
        }
    }
    
    //MARK: - Search bar delegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            if isPromotional {
                search_offers(term: searchBar.text!)
            } else{
                search_products(term: searchBar.text!)
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            if isPromotional {
                download_offers()
                
            }else{
                download_products()
            }
            searchBar.resignFirstResponder()
        }
    }

    // MARK: - Custom segmented control delegate methods
    func segmentedControl(_ control: SWSegmentedControl, didDeselectItemAtIndex index: Int) {
        if index == 0 {
            download_offers()
        }else{
            download_products()
        }
    }
    
    // MARK: - Table view delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 10){
            return arrMenuItens.count
        }else{
            if (self.offers?.data != nil) {
                if self.offers?.data.count == 0 {
                    if isPromotional{
                        PlaceHolderMessage.showPlacheholderMessage(message:"Nenhuma promoção encontrada.",view: self.tbOffers,verticalBias: 1.0)
                    }else{
                        PlaceHolderMessage.showPlacheholderMessage(message:"Nenhum produto encontrado.",view: self.tbOffers,verticalBias: 1.0)
                    }
                }else{
                    PlaceHolderMessage.showPlacheholderMessage(message:" ",view: self.tbOffers,verticalBias: 1.0)
                }
                return self.offers!.data.count
            }else{
                if isPromotional{
                    PlaceHolderMessage.showPlacheholderMessage(message:"Nenhuma promoção a ser exibida. Verifique sua conexão.",view: self.tbOffers,verticalBias: 1.0)
                }else{
                    PlaceHolderMessage.showPlacheholderMessage(message:"Nenhum produto a ser exibido. Verifique sua conexão.",view: self.tbOffers,verticalBias: 1.0)
                }
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 10){
            let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell", for: indexPath) as! MenuItemTableViewCell
            cell.setup_cell(mItem: arrMenuItens[indexPath.row], mItemImage: arrMenuItensImage[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "offer_cell", for: indexPath) as! OfferTableViewCell
            let offer:OfferData = (self.offers?.data[indexPath.row])!
            cell.delegate  = self
            cell.indexPath = indexPath
            if isPromotional {
                cell.setup_offer_cell(offer: offer, aatc: "ADICIONADO", atc: "ADICIONAR")
            }else{
                cell.setup_product_cell(offer: offer, aatc: "ADICIONADO", atc: "ADICIONAR")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView.tag == 10){
            return 54
        }else{
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 100
            case .pad:
                return 200
            case .tv:
                return 0
            case .carPlay:
                return 0
            case .unspecified:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.tag == 10{
            select_menu_item(item: indexPath.row)
        }else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let product_detail_vc:ProductDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "product_detail_vc") as! ProductDetailViewController
            product_detail_vc.offer = self.offers?.data[indexPath.row]
            product_detail_vc.isPromotional = isPromotional
            self.navigationController?.pushViewController(product_detail_vc, animated: true)
        }
    }
    
    // MARK: - Menu methods
    func select_menu_item (item:Int){
        switch item {
        case 0:
            do_menu_animation()
            if (UserDataDAO.check_if_is_logged() == false){
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let login_vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login_vc") as! ViewController
                self.navigationController?.pushViewController(login_vc, animated: true)
            }else {
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let my_orders_vc:MyOrdersViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "my_orders_vc") as! MyOrdersViewController
                self.navigationController?.pushViewController(my_orders_vc, animated: true)
            }
            break
            
        case 1:
            do_menu_animation()
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let shopping_cart_vc:ShoppingCartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shopping_cart_vc") as! ShoppingCartViewController
            self.navigationController?.pushViewController(shopping_cart_vc, animated: true)
            break
            
        case 2:
            do_menu_animation()
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let contact_us_vc:ContactUsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contact_us_vc") as! ContactUsViewController
            self.navigationController?.pushViewController(contact_us_vc, animated: true)
            break
            
        case 3:
            if (UserDataDAO.check_if_is_social_media_user()){
                logout()
            }else{
                do_menu_animation()
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let edit_password_vc:EditPasswordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "edit_password_vc") as! EditPasswordViewController
                self.navigationController?.pushViewController(edit_password_vc, animated: true)
            }
            break
            
        default:
            logout()
        }
    }
    
    @IBAction func open_or_close_menu(_ sender: Any) {
        do_menu_animation()
    }
    
    func do_menu_animation(){
        if (isMenuOpen == 0){
            UIView.animate(withDuration: 0.3) {
                self.tbMenuLeadingConstrain.constant = 0
                self.tbMenuHeaderLeadingConstrain.constant = 0
                self.view.layoutIfNeeded()
            }
            isMenuOpen = 1
        }else{
            UIView.animate(withDuration: 0.3) {
                self.tbMenuLeadingConstrain.constant = -315
                self.tbMenuHeaderLeadingConstrain.constant = -315
                self.view.layoutIfNeeded()
            }
            isMenuOpen = 0
        }
    }
    
    // MARK: - Authentication methods
    func logout(){
        var alert:UIAlertController!
        alert = UIAlertController(title: "Atenção!", message: "Você realmente deseja sair?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { action in
            self.really_logout()
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func really_logout(){
        arr_cart.removeAll()
        UserDataDAO.clean_local_data()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
        self.present(home_nav_vc, animated: false, completion: nil)
    }
    
    // MARK: - Cart methods
    func add_product_to_cart(at index: IndexPath) {
        if (!arr_cart.contains(where: {$0.id == self.offers!.data[index.row].id})){
            let offer:OfferData = self.offers!.data[index.row]
            offer.quantity  = 1
            if isPromotional {
                offer.isPromotional = 1
            }else{
                offer.isPromotional = 0
            }
            arr_cart.append(offer)
            bbCart.addBadge(text: "\(arr_cart.count)")
            tbOffers.reloadData()
        }else {
            arr_cart = arr_cart.filter() { $0.cod != self.offers!.data[index.row].cod }
            bbCart.addBadge(text: "\(arr_cart.count)")
            tbOffers.reloadData()
        }
    }
    
    @IBAction func open_shopping_cart(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let shopping_cart_vc:ShoppingCartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shopping_cart_vc") as! ShoppingCartViewController
        self.navigationController?.pushViewController(shopping_cart_vc, animated: true)
    }

    //MARK: - Util methods
    @IBAction func hideSearchKeyboard(_ sender: Any) {
        self.searchBar.resignFirstResponder()
        if isMenuOpen == 1 {
            do_menu_animation()
        }
    }
    
}

