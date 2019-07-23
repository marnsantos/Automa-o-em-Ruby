//
//  PickerCustomHour.swift
//  Pescatta
//
//  Created by MacITBAM01 on 17/08/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

protocol PickerViewHourSelected {
    func hourSelected(hour:String)
}

class PickerCustomHour: NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var delegate:PickerViewHourSelected?
    var arrData:[String] = []
    
    init (arrData:[String]){
        self.arrData = arrData
    }
    
    //MARK: - PickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrData[row]
    }
    
    //MARK: - PickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.hourSelected(hour: arrData[row])
        }
    }
    
}
