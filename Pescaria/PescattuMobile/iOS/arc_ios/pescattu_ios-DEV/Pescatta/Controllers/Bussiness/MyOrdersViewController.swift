//
//  MyOrdersViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 07/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire

class MyOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbOrders: UITableView!
    var history:OrderHistory!
    var phMessage:UILabel!
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tbOrders.delegate = self
        tbOrders.dataSource = self
        download_orders()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - REST methods
    func download_orders(){
        self.history = nil
        self.view.makeToastActivity(.center)
        APIClient.get_orders_by_user { response in
            switch response.result {
            case .success (let history):
                self.view.hideToastActivity()
                if response.response?.statusCode == 200 {
                    self.history = history
                    self.tbOrders.reloadData()
                }else{
                    PlaceHolderMessage.showPlacheholderMessage(message:"Não foi possível carregar o histórico.",view: self.tbOrders,verticalBias: 0.9)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                PlaceHolderMessage.showPlacheholderMessage(message:"Não foi possível carregar o histórico.",view: self.tbOrders,verticalBias: 0.9)
                print(error)
            }
        }
    }
    
    //MARK: - Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if (history != nil){
            if history.data.count > 0 {
                PlaceHolderMessage.showPlacheholderMessage(message:"",view: self.tbOrders,verticalBias: 1.0)
            }else {
                PlaceHolderMessage.showPlacheholderMessage(message:"Nenhum pedido no histórico.",view: self.tbOrders,verticalBias: 0.9)
            }
            return history.data.count
            
        }
        PlaceHolderMessage.showPlacheholderMessage(message:"Não foi possível carregar histórico.",view: self.tbOrders,verticalBias: 0.9)
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order_cell", for: indexPath) as! OrderTableViewCell
        let order:OrderData  = self.history.data[indexPath.section] as OrderData
        cell.setup_cell(order: order,o: "Pedido",i: "em")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let order_tracker_vc:OrderTrackerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "order_tracker_vc") as! OrderTrackerViewController
        order_tracker_vc.trackedId = history.data[indexPath.section].orderId
        self.navigationController?.pushViewController(order_tracker_vc, animated: true)
    }
    
}
