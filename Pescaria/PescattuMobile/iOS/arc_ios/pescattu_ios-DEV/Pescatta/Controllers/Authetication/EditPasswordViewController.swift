
//
//  EditPasswordViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 09/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire
import BCryptSwift

class EditPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfNewPasswordConfirmation: UITextField!
    @IBOutlet weak var btSave: UIButton!
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        tfCurrentPassword.delegate = self
        tfNewPassword.delegate = self
        tfNewPasswordConfirmation.delegate = self
        ViewChanges.applyCornerRoundTo(button: btSave)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - REST methods
    @IBAction func save_new_password(_ sender: Any) {
        if (tfCurrentPassword.text != "" && tfNewPassword.text != "" && tfNewPasswordConfirmation.text != ""){
            if (tfNewPassword.text == tfNewPasswordConfirmation.text){
                self.view.makeToastActivity(.center)
                //let passwordHash = BCryptSwift.hashPassword(tfCurrentPassword.text!, withSalt: BCryptSwift.generateSaltWithNumberOfRounds(5))
                //let newPasswordHash = BCryptSwift.hashPassword(tfNewPassword.text!, withSalt: BCryptSwift.generateSaltWithNumberOfRounds(5))
                APIClient.save_new_password(new_password: tfNewPassword.text!, current_password: tfCurrentPassword.text!) { response in
                    switch response.result {
                        case .success:
                            if response.response?.statusCode == 200 {
                                self.view.makeToast("Sua senha foi alterada.", duration: 1.5, position: .center){ didTap in
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }else{
                                self.view.makeToast("Ocorreu um erro ao tentar alterar a sua senha. verifique sua senha atual", duration: 1.5, position: .center)
                            }
                            break
                        
                        case .failure(let error):
                            self.view.makeToast("Ocorreu um erro  ao tentar alterar a sua senha.", duration: 1.5, position: .center)
                            print(error)
                    }
                }
            } else{
                self.view.makeToast("Senha e confirmação de senha diferentes.", duration: 0.75, position: .center)
            }
        } else {
            self.view.makeToast("Todos os campos precisam ser preenchidos.", duration: 0.75, position: .center)
        }
    }
    
    //MARK: - Util methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
