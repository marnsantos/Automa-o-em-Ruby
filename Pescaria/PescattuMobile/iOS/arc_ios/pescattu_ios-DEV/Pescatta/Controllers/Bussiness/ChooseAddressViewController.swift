//
//  ChooseAddressViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 08/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire

class ChooseAddressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbAddresses: UITableView!
    @IBOutlet weak var btConfirm: UIButton!
    var choosenAddress:Int = 0
    var addresses:Address!
    var phMessage:UILabel!
    
    //MARK: - Life cicle methods
    override func viewWillAppear(_ animated: Bool) {
        download_addresses()
        choosenAddress = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConfirm)
        tbAddresses.delegate = self
        tbAddresses.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - REST methods
    func download_addresses(){
        self.view.makeToastActivity(.center)
        APIClient.download_addresses { response in
            switch response.result {
            case .success (let addresses):
                self.view.hideToastActivity()
                self.addresses = addresses
                if response.response?.statusCode == 200 {
                    self.tbAddresses.reloadData()
                }else {
                    if self.addresses.errors != nil {
                        PlaceHolderMessage.showPlacheholderMessage(message:(self.addresses.errors?[0])!, view: self.tbAddresses,verticalBias: 1.0)
                    }else{
                        PlaceHolderMessage.showPlacheholderMessage(message:"Falha na conexão.", view: self.tbAddresses,verticalBias: 1.0)
                    }
                    self.btConfirm.isHidden = true
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                PlaceHolderMessage.showPlacheholderMessage(message:"Erro ao carregar endereços. Verifique sua conexão.",view: self.tbAddresses,verticalBias: 1.0)
                self.btConfirm.isHidden = true
                print(error)
            }
        }
    }
    
    //MARK: - Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.addresses != nil)
        {
            if self.addresses.data.count > 0 {
                PlaceHolderMessage.showPlacheholderMessage(message:"",view: self.tbAddresses,verticalBias: 1.0)
                self.btConfirm.isHidden = false
            }else {
                PlaceHolderMessage.showPlacheholderMessage(message:"Nenhum endereço a ser listado.",view: self.tbAddresses,verticalBias: 1.0)
                self.btConfirm.isHidden = true
            }
            return self.addresses.data.count
        }
        PlaceHolderMessage.showPlacheholderMessage(message:"Erro ao carregar endereços. Verifique sua conexão.",view: self.tbAddresses,verticalBias: 1.0)
        self.btConfirm.isHidden = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell", for: indexPath) as! AddressTableViewCell
        let address = self.addresses!.data![indexPath.section]
        cell.indexPath = indexPath
        cell.setup_cell(address: address, choosenAddress: choosenAddress)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 65
        case .pad:
            return 130
        case .tv:
            return 0
        case .carPlay:
            return 0
        case .unspecified:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenAddress = indexPath.section
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if (addresses.data[indexPath.row].userId != nil) {
            let delete = UITableViewRowAction(style: .destructive, title: "Excluir") { (action, indexPath) in
                self.view.makeToastActivity(.center)
                let addressId = self.addresses!.data![indexPath.section].addressId!
                APIClient.delete_address(addressId: addressId, completion: { response in
                    switch response.result {
                    case .success (let addressResponse):
                        self.view.hideToastActivity()
                        if response.response?.statusCode == 200 {
                            if self.addresses != nil {
                                if self.addresses.data.count > 1 {
                                    self.view.makeToast(addressResponse.data, duration: 1.5, position: .center)
                                    self.choosenAddress = 0
                                }
                            }
                            self.download_addresses()
                        }else {
                            self.view.makeToast(addressResponse.errors[0], duration: 2.0, position: .center)
                        }
                        break
                        
                    case .failure(let error):
                        self.view.hideToastActivity()
                        print(error)
                    }
                }
            )}
            let edit = UITableViewRowAction(style: .default, title: "Editar") { (action, indexPath) in
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let add_address_vc:AddAddressViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "add_address_vc") as! AddAddressViewController
                add_address_vc.isEditingAddress = true
                add_address_vc.addressToEdit = self.addresses!.data![indexPath.section]
                self.navigationController?.pushViewController(add_address_vc, animated: true)
            }
            edit.backgroundColor = UIColor.lightGray
            return [delete,edit]
        }
        return []
    }
    

    //MARK: - Bussiness rules methods
    @IBAction func confirm_address(_ sender: Any) {
        if(self.addresses == nil){
            self.view.makeToast("Nenhum endereço selecionado.", duration: 0.75, position: .center)
            return
        }
        if (self.addresses.data!.count > 0){
            //Apply when schedule is ok
            //checkIfWillFly()
            //Remove when schedule is ok
            UserDataDAO.save_choosen_address_id(addressId: self.addresses.data[choosenAddress].addressId!)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let payment_vc:PaymentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "payment_vc") as! PaymentViewController
            self.navigationController?.pushViewController(payment_vc, animated: true)
        }else {
            self.view.makeToast("Nenhum endereço selecionado.", duration: 0.75, position: .center)
        }
    }
    
    func checkIfWillFly(){
        UserDataDAO.save_choosen_address_id(addressId: self.addresses.data[choosenAddress].addressId!)
        var alert:UIAlertController!
        alert = UIAlertController(title: "", message:"Você vai viajar?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { action in
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let kind_of_flight_vc:KindOfFlightViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "kind_of_flight_vc") as! KindOfFlightViewController
            self.navigationController?.pushViewController(kind_of_flight_vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: { action in
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let schedule_vc:ScheduleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "schedule_vc") as! ScheduleViewController
            //payment_vc.addressOfOrder = self.addresses.data![self.choosenAddress].addressId!
            self.navigationController?.pushViewController(schedule_vc, animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    //MARK: - Navigation methods
    @IBAction func go_to_add_address(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let add_address_vc:AddAddressViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "add_address_vc") as! AddAddressViewController
        add_address_vc.isEditingAddress = false
        self.navigationController?.pushViewController(add_address_vc, animated: true)
    }
    
}
