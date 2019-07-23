//
//  KindOfFlightViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 16/08/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class KindOfFlightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var btConclude: UIButton!
    @IBOutlet weak var tbKindOfFlights: UITableView!
    var choosenFlightKind:Int = 0
    var arrKindOfFlights = ["Vôo regional","Vôo nacional", "Vôo internacional"]
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tbKindOfFlights.delegate = self
        tbKindOfFlights.dataSource = self
        tbKindOfFlights.tableFooterView = UIView()
        ViewChanges.applyCornerRoundTo(button: btConclude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrKindOfFlights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kind_of_flight_cell", for: indexPath) as! KindOfFlightTableViewCell
        cell.setup_cell(kindOfFlight: arrKindOfFlights[indexPath.row],indexPath: indexPath,choosenFlightKind: choosenFlightKind)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenFlightKind = indexPath.row
        tbKindOfFlights.reloadData()
    }

    @IBAction func conclude(_ sender: Any) {
        UserDataDAO.save_choosen_flight_type(flight_type: choosenFlightKind)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let schedule_vc:ScheduleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "schedule_vc") as! ScheduleViewController
        self.navigationController?.pushViewController(schedule_vc, animated: true)
    }
}
