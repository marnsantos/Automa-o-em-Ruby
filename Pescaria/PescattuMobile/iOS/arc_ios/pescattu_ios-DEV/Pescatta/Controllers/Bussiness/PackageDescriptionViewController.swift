//
//  PackageDescriptionViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 16/08/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class PackageDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tbProducts: UITableView!
    @IBOutlet weak var tbDescription: UITableView!
    @IBOutlet weak var btConclude: UIButton!
    
    //Mark: - Life cile  methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConclude)
        tbProducts.tableFooterView = UIView()
        tbDescription.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10 {
            return 5
        }
        return arr_cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "package_item_cell", for: indexPath) as! ResumeItemTableViewCell
        if tableView.tag == 10 {
            
        }else {
            cell.setupCell(description: arr_cart[indexPath.row].name, price: arr_cart[indexPath.row].priceApp)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 10 {
            return 40
        }
        return 30
    }
    
    //MARK: - Info Methods
    @IBAction func showInfo(_ sender: Any) {
        var alert:UIAlertController!
        alert = UIAlertController(title: "", message:"De acordo com a Lei 666.22 de 05/08/1997, sobre produtos alimentícios.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: - Navigation methods
    @IBAction func conclude(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let payment_vc:PaymentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "payment_vc") as! PaymentViewController
        //payment_vc.addressOfOrder = self.addresses.data![self.choosenAddress].addressId!
        self.navigationController?.pushViewController(payment_vc, animated: true)
    }

}
