//
//  EditProfileViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 09/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfName: HoshiTextField!
    @IBOutlet weak var tfCPF: HoshiTextField!
    @IBOutlet weak var tfEmail: HoshiTextField!
    @IBOutlet weak var tfPhone: HoshiTextField!
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        set_delegates()
        let userName:String = UserDataDAO.get_user_name()
        tfName.text = userName
        let userEmail:String = UserDataDAO.get_user_email()
        tfEmail.text = userEmail
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup methods
    func set_delegates(){
        tfName.delegate = self
        tfCPF.delegate = self
        tfEmail.delegate = self
        tfPhone.delegate = self
    }
    
    //MARK: - Bussiness rules methods
    @IBAction func edit_password(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let edit_password_vc:EditPasswordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "edit_password_vc") as! EditPasswordViewController
        self.navigationController?.pushViewController(edit_password_vc, animated: true)
    }
    
    @IBAction func save_profile(_ sender: Any) {
        if (tfName.text != "" && tfCPF.text != "" && tfEmail.text != "" && tfPhone.text != ""){
//            self.view.makeToastActivity(.center)
//            let userId:Int = UserDefaults.standard.object(forKey: USER_ID) as! Int
//            let user:[String: Any] = ["id":userId, "nome":tfName.text!, "phone":tfPhone.text!, "cpf": tfCPF.text!, "email":tfEmail.text!, "system":"PESCATTU"]
//            let userToken = UserDefaults.standard.object(forKey: USER_TOKEN)
//            let headers = ["Authorization": "\(userToken ?? "")","Content-Type" :"application/json"]
//            Alamofire.request("\(host)/user-mobile/", method: .put, parameters:user, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
//                self.view.hideToastActivity()
//                switch response.result {
//                case .success:
//                    if response.response?.statusCode == 200 {
//                        self.view.makeToast("Seu perfil foi alterado.", duration: 1.5, position: .center){ didTap in
//                            self.navigationController?.popViewController(animated: true)
//                        }
//                    }else{
//                        self.view.makeToast("Ocorreu um erro ao tentar atualizar seu perfil.", duration: 1.5, position: .center)
//                    }
//                    break
//                    
//                case .failure(let error):
//                    self.view.makeToast("Ocorreu um erro ao tentar atualizar seu perfil.", duration: 1.5, position: .center)
//                    print(error)
//                }
//            }
        }else{
             self.view.makeToast("Todos os campos são obrigatórios.", duration: 1.5, position: .center)
        }
    }
    
    //MARK: - Util methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
