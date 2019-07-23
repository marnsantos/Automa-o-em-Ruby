//
//  OrderAuthorizedViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 09/05/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class OrderAuthorizedViewController: UIViewController {
    
    @IBOutlet weak var vCard: UIView!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var lbOrderNumber: UILabel!
    var orderNumber:Int!
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btBack)
        ViewChanges.applyShadowTo(view: vCard)
        arr_cart.removeAll()
        lbOrderNumber.text = " \(orderNumber!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Navigation methods
    @IBAction func go_to_home(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
        self.present(home_nav_vc, animated: false, completion: nil)
    }
    
}
