//
//  ScheduleViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 16/08/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import TextFieldEffects

class ScheduleViewController: UIViewController, PickerViewDateSelected, PickerViewHourSelected {

    @IBOutlet weak var btConclude: UIButton!
    @IBOutlet weak var tfDeliverDate: HoshiTextField!
    @IBOutlet weak var tfDeliverHour: HoshiTextField!
    
    var pickerDataDay = PickerCustomData(arrData: ["day 01", "day 02", "day 03"])
    var pickerDataHour = PickerCustomHour(arrData: ["hour 01", "hour 02", "hour 03", "hour 04", "hour 05"])
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConclude)
        pickerDataDay.delegate = self
        pickerDataHour.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Selected Data
    func dateSelected(date: String) {
        tfDeliverDate.text = date
    }
    
    func hourSelected(hour: String) {
        tfDeliverHour.text = hour
    }
    
    @IBAction func dateTextFocus(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerDataDay
        pickerView.dataSource = pickerDataDay
        sender.inputView = pickerView
    }
    
    @IBAction func hourTextFocus(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerDataHour
        pickerView.dataSource = pickerDataHour
        sender.inputView = pickerView
    }
    
    //MARK: - Navigation methods
    @IBAction func conclude(_ sender: Any) {
        var alert:UIAlertController!
        alert = UIAlertController(title: "", message:"Agendamento realizado com sucesso.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let package_description_vc:PackageDescriptionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "package_description_vc") as! PackageDescriptionViewController
            self.navigationController?.pushViewController(package_description_vc, animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    // MARK: - Util methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
