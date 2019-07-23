//
//  NewTransireUserViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 16/07/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import TextFieldEffects
class NewTransireUserViewController: UIViewController {

    @IBOutlet weak var tfNewPassword: HoshiTextField!
    @IBOutlet weak var tfNewPasswordConfirmation: HoshiTextField!
    @IBOutlet weak var tfNewEmail: HoshiTextField!
    @IBOutlet weak var btSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btSave)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func authenticateTransireUser(_ sender: Any) {
        if ((tfNewEmail.text?.isEmpty)! && (tfNewPassword.text?.isEmpty)! && (tfNewPasswordConfirmation.text?.isEmpty)!){
            self.view.makeToast("Todos os campos são de preenchimento obrigatório.", duration: 1.0, position: .center)
        }else if (tfNewPassword.text! != tfNewPasswordConfirmation.text!){
            self.view.makeToast("Senha apresentada difere de sua confirmação.", duration: 1.0, position: .center)
        }else{
            APIClient.first_login(email: tfNewEmail.text!, password: tfNewPassword.text!) { response in
                switch response.result {
                case .success (let firstLogin):
                    self.view.hideToastActivity()
                    if response.response?.statusCode == 200 {
                        self.view.hideToastActivity()
                        self.navigationController?.popViewController(animated: false)
                    } else {
                        self.view.hideToastActivity()
                        self.view.makeToast(firstLogin.errors?[0], duration: 1.0, position: .center)
                    }
                    break
                    
                case .failure(let error):
                    self.view.makeToast("Não foi possível autenticar seu usuário. Tente novamente.", duration: 1.0, position: .center)
                    self.view.hideToastActivity()
                    print(error)
                }
            }
        }
    }
    
}
