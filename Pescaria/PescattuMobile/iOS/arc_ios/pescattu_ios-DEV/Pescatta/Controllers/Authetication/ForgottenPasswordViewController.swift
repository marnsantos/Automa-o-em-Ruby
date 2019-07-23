//
//  ForgottenPasswordViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 15/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire

class ForgottenPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btConfirm: UIButton!
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPassword.delegate = self
        ViewChanges.applyCornerRoundTo(button: btConfirm)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Rest methods
    @IBAction func confirm_operation(_ sender: Any) {
        if (!(tfPassword.text?.isEmpty)!){
            self.view.makeToastActivity(.center)
            APIClient.recover_password(email: tfPassword.text!) { response in
                switch response.result {
                    case .success:
                        self.view.hideToastActivity()
                        if response.response?.statusCode == 200 {
                            self.view.makeToast("Uma senha provisória foi enviada para o seu e-mail.", duration: 1.5, position: .center){ didTap in
                                self.navigationController?.popViewController(animated: true)
                            }
                        }else {
                            self.view.makeToast("Erro. Verifique se foi utilizado um e-mail válido.", duration: 1.5, position: .center)
                        }
                        break
    
                    case .failure(let error):
                        self.view.hideToastActivity()
                        self.view.makeToast("Ocorreu um erro ao tentar recuperar sua senha. Verifique sua conexão.", duration: 1.5, position: .center)
                        print(error)
                }
            }
        } else{
            self.view.makeToast("Campo e-mail precisa ser preenchido", duration: 0.75, position: .center)
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
