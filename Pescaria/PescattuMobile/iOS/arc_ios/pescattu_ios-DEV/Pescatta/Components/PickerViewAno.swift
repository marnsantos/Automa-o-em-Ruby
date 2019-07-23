//
//  PickerViewAno.swift
//  Alura Ingressos
//
//  Created by Alura on 03/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

protocol PickerViewAnoSelecionado {
    func anoSelecionado(ano:String)
}

class PickerViewAno: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Variáveis
    
    var listaDeAnos = [String]()
    var delegate:PickerViewAnoSelecionado?

    //MARK: - PickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let date = Date()
        let calendar = Calendar.current
        
        let year:Int = calendar.component(.year, from: date)
        for i in (0..<11)
        {
            listaDeAnos.append("\(year + i)")
        }
        return listaDeAnos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let anoAtual = listaDeAnos[row]
        return anoAtual
    }
    
    //MARK: - Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.anoSelecionado(ano: listaDeAnos[row])
        }
    }

}
