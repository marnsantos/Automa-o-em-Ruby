//
//  EmployeeLoginViewController.swift
//  Pescatta-Teste
//
//  Created by Andrew Almeida Chaves do Vale on 27/02/2018.
//  Copyright © 2018 Andrew Almeida Chaves do Vale. All rights reserved.
//

import UIKit
import Alamofire
import BCryptSwift

class EmployeeLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfRegistrationNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btConfirm: UIButton!
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConfirm)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Login methods (REST)
    @IBAction func employee_login(_ sender: Any){
        if (tfRegistrationNumber.text != "" && tfPassword.text != ""){
            self.view.makeToastActivity(.center)
            //let passwordHash = BCryptSwift.hashPassword(tfPassword.text!, withSalt: BCryptSwift.generateSaltWithNumberOfRounds(5))
            APIClient.login_employee(login: tfRegistrationNumber.text!, password: tfPassword.text!) { response in
                switch response.result {
                case .success(let user):
                    if response.response?.statusCode == 200{
                        if (user.data?.permissoes.contains("FUNCIONARIO"))!{
                            
                            self.view.hideToastActivity()
                            self.tfRegistrationNumber.text = ""
                            self.tfPassword.text = ""
                            if user.data?.firstLogin == true {
                                UserDataDAO.save_transire_unregistered_user_token(userToken: user.data!.token)
                                UserDataDAO.save_transire_unregistered_user_id(userId: user.data!.id)
                                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                let new_transire_user_vc:NewTransireUserViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "new_transire_user_vc") as! NewTransireUserViewController
                                self.navigationController?.pushViewController(new_transire_user_vc, animated: false)
                            }else{
                                UserDataDAO.save_transire_user_data(userName: user.data!.name, userId: user.data!.id, userToken: user.data!.token, userEmail: user.data!.email)
                                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
                                self.present(home_nav_vc, animated: false, completion: nil)
                            }
                        } else{
                            self.view.hideToastActivity()
                            self.view.makeToast("Usuário não habilitado para logar como funcionário.", duration: 1.0, position: .center)
                        }
                    }else{
                        self.view.hideToastActivity()
                        self.view.makeToast(user.errors?[0], duration: 1.0, position: .center)
                    }
                case .failure(let error):
                    self.view.hideToastActivity()
                    self.view.makeToast("Não foi possível realizar o login. Verifique sua conexão.", duration: 1.0, position: .center)
                    print(error)
                }
            }
        } else{
            self.view.makeToast("Todos os campos são obrigatórios.", duration: 1.0, position: .center)
        }
    }
    
    //MARK: - Util methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Navigation methods
    @IBAction func forgotten_password(_ sender: Any) {
        var alert:UIAlertController!
        alert = UIAlertController(title: "Olá", message: "Verifique junto ao RH a alteração da sua senha.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

