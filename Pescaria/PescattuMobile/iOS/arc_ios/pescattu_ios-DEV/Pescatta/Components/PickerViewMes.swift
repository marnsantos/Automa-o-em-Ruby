//
//  PickerViewMes.swift
//  Alura Ingressos
//
//  Created by Alura on 03/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

protocol PickerViewMesSelecionado {
    func mesSelecionado(mes:String)
}

class PickerViewMes: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate:PickerViewMesSelecionado?
    
    //MARK: - PickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if ((row + 1) < 10) {
            return "0\(row+1)"
        }
        return "\(row+1)"
    }
    
    //MARK: - PickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            if (row + 1) < 10 {
                delegate?.mesSelecionado(mes: "0\(row+1)")
            }else {
                delegate?.mesSelecionado(mes: "\(row+1)")
            }
        }
    }
}
