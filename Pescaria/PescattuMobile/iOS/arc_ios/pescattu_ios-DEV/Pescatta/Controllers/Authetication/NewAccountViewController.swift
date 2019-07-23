//
//  NewAccountViewController.swift
//  Pescatta-Teste
//
//  Created by Andrew Almeida Chaves do Vale on 27/02/2018.
//  Copyright © 2018 Andrew Almeida Chaves do Vale. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import BCryptSwift


class NewAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordConfirmation: UITextField!
    @IBOutlet weak var btConfirm: UIButton!
    var user:User!
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConfirm)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - REST methods
    @IBAction func submit_form_data(_ sender: Any) {
        if (tfName.text == "" || tfCPF.text == "" || tfPhone.text == "" || tfEmail.text == "" || tfPassword.text == "" || tfPasswordConfirmation.text == ""){
            self.view.makeToast("Todos os campos são obrigatórios.", duration: 1.0, position: .center)
        } else {
            if (tfPassword.text != tfPasswordConfirmation.text){
                self.view.makeToast("Confirmação de senha inválida.", duration: 1.0, position: .center)
            } else {
                self.view.makeToastActivity(.center)
                //let passwordHash = BCryptSwift.hashPassword(tfPassword.text!, withSalt: BCryptSwift.generateSaltWithNumberOfRounds(5))
                APIClient.create_user(name: tfName.text!, phone: tfPhone.text!, email: tfEmail.text!, password: tfPassword.text!, cpf: tfCPF.text!) { response in
                    switch response.result {
                        case .success (let user):
                            self.view.hideToastActivity()
                            if response.response?.statusCode == 200 {
                                self.clear_text_fields()
                                 UserDataDAO.save_external_user_data(userName: user.data!.name, userId: user.data!.id, userToken: user.data!.token, userEmail: user.data!.email)
                                self.view.hideToastActivity()
                                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
                                self.present(home_nav_vc, animated: false, completion: nil)
                            } else {
                                self.view.hideToastActivity()
                                self.view.makeToast(user.errors?[0], duration: 1.0, position: .center)
                            }
                            break
    
                        case .failure(let error):
                            self.view.makeToast("Não foi possível realizar o cadastro. Verifique sua conexão.", duration: 1.0, position: .center)
                            self.view.hideToastActivity()
                            print(error)
                    }
                }
            }
        }
    }
    
    //MARK: - Navigation methods
    @IBAction func go_to_terms_of_use(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let terms_of_use_vc:UseTermsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "terms_of_use_vc") as! UseTermsViewController
        self.navigationController?.pushViewController(terms_of_use_vc, animated: true)
    }
    
    @IBAction func go_to_cancellation_policy(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let cancellation_policy_vc:CancellationPolicyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cancellation_policy_vc") as! CancellationPolicyViewController
        self.navigationController?.pushViewController(cancellation_policy_vc, animated: true)
    }
    
    //MARK: - Util methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func clear_text_fields(){
        tfName.text = ""
        tfCPF.text = ""
        tfPhone.text = ""
        tfEmail.text = ""
        tfPassword.text = ""
        tfPasswordConfirmation.text = ""
    }
    
    func show_alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: - Text field lenght validator
    @IBAction func verififyNumberOfCharacters(_ sender: Any) {
        if ((sender as! UITextField).tag == 20) {
            checkMaxLength(textField: (sender as!  UITextField), maxLength: 11)
        } else if ((sender as! UITextField).tag == 30) {
            checkMaxLength(textField: (sender as!  UITextField), maxLength: 11)
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if ((textField.text?.count)! > maxLength) {
            textField.deleteBackward()
        }
    }
}


