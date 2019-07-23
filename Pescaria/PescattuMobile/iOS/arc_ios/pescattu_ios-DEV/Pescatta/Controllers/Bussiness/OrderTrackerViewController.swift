//
//  OrderTrackerViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 07/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire

class OrderTrackerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tbTracking: UITableView!
    @IBOutlet weak var btCancelOrder: UIButton!
    @IBOutlet weak var deliverCode: UILabel!
    @IBOutlet weak var vCard: UIView!
    var arrStatus = [DeliverStatus]()
    var trackedId:Int!
    
    //MARK: - Life cicle methods
    override func viewWillAppear(_ animated: Bool) {
        if (UserDataDAO.check_if_is_transire_user()){
            btCancelOrder.isHidden = true
            vCard.isHidden = true
            PlaceHolderMessage.showPlacheholderMessage(message:"Informe-se sobre seu pedido no RH.",view: self.view,verticalBias: 1.0)
        }else{
            request_for_transporting_status()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pedido \(trackedId!)"
        ViewChanges.applyCornerRoundTo(button: btCancelOrder)
        tbTracking.delegate = self
        tbTracking.dataSource = self
        tbTracking.tableFooterView = UIView()
        ViewChanges.applyShadowTo(view: vCard)
    }
    
    //MARK: - Bussiness methods
    @IBAction func cancel_order(_ sender: Any) {
        let alert = UIAlertController(title: "Atenção", message: "Você realmente deseja cancelar esse pedido?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { action in
            self.really_cancel_order()
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: - REST methods
    func request_for_transporting_status(){
        self.view.makeToastActivity(.center)
        APIClient.get_order_status(trackedId: trackedId!) { response in
            switch response.result {
            case .success(let order):
                self.view.hideToastActivity()
                if response.response?.statusCode == 200 {
                    if (order.data.status == "PENDENTE"){
                        let status = DeliverStatus(status:"PENDENTE",date:DateUtil.formateDateFrom(date: order.data.odate!))
                        self.arrStatus = [status]
                    }else if(order.data.status == "ENTREGUE"){
                        let status = DeliverStatus(status:"ENTREGUE",date:DateUtil.formateDateFrom(date: order.data.odate!))
                        self.arrStatus = [status]
                        self.vCard.isHidden = true
                        self.btCancelOrder.isHidden  = true
                    }else if (order.data.status == "CANCELADO"){
                        let status = DeliverStatus(status:"CANCELADO",date:DateUtil.formateDateFrom(date: order.data.odate!))
                        self.arrStatus = [status]
                        self.vCard.isHidden = true
                        self.btCancelOrder.isHidden  = true
                    }else if (order.data.status == "EM_TRANSITO"){
                        let status = DeliverStatus(status:"EM TRÂNSITO",date:DateUtil.formateDateFrom(date: order.data.odate!))
                        self.arrStatus = [status]
                        self.vCard.isHidden = true
                        self.btCancelOrder.isHidden  = true
                    }
                    self.tbTracking.reloadData()
                }else {
                    self.btCancelOrder.isHidden = true
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.btCancelOrder.isHidden = true
                print(error)
            }
        }
    }
    
    func really_cancel_order(){
        self.view.makeToastActivity(.center)
        APIClient.cancel_order(trackedId: trackedId!) { response in
            switch response.result {
            case .success(let order):
                self.view.hideToastActivity()
                if response.response?.statusCode == 200 {
                    if order.data.status == "CANCELADO" {
                        self.request_for_transporting_status()
                    }
                }else {
                    self.view.makeToast(order.errors[0], duration: 1.0, position: .center)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                print(error)
            }
        }
    }
    
    //MARK: - Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStatus.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tracking_cell", for: indexPath) as! TrackingTableViewCell
        cell.lbStatus.text = arrStatus[indexPath.row].status
        cell.lbDate.text = arrStatus[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 70
        case .pad:
            return 100
        case .tv:
            return 0
        case .carPlay:
            return 0
        case .unspecified:
            return 0
        }
    }

}
