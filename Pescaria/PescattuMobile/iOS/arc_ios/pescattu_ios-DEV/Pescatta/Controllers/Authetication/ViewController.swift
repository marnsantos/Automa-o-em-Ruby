//
//  ViewController.swift
//  Pescatta-Teste
//
//  Created by Andrew Almeida Chaves do Vale on 26/02/2018.
//  Copyright © 2018 Andrew Almeida Chaves do Vale. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import Alamofire
import AlamofireObjectMapper
import Toast_Swift
import BCryptSwift

class ViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate{
    
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    
    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btLogin)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Login methods (REST)
    @IBAction func login_traditional(_ sender: Any) {
        external_user_login()
    }
    
    func external_user_login(){
        if (tfLogin.text != "" && tfPassword.text != ""){
            self.view.makeToastActivity(.center)
            //let passwordHash = BCryptSwift.hashPassword(tfPassword.text!, withSalt: BCryptSwift.generateSaltWithNumberOfRounds(5))
            APIClient.login(login: tfLogin.text!, password: tfPassword.text!) { response in
                switch response.result {
                case .success(let user):
                    if response.response?.statusCode == 200{
                        if (user.data?.permissoes.contains("EXTERNO"))!{
                            UserDataDAO.save_external_user_data(userName: user.data!.name, userId: user.data!.id, userToken: user.data!.token, userEmail: user.data!.email)
                            self.view.hideToastActivity()
                            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
                            self.present(home_nav_vc, animated: false, completion: nil)
                        } else{
                            self.view.hideToastActivity()
                             self.view.makeToast("Usuário não habilitado para logar como externo.", duration: 1.0, position: .center)
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
            self.view.makeToast("Todos os campos são de preenchimento obrigatório.", duration: 1.0, position: .center)
        }
    }
    
    @IBAction func login_with_google(_ sender: Any) {
        self.view.makeToastActivity(.center)
        GIDSignIn.sharedInstance().clientID   = "1075448340065-oiij7n5e65fn1t9fj61ndb8ait3vqu1f.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate   = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
        if let error = error {
            self.view.hideToastActivity()
            print("\(error.localizedDescription)")
        } else {
            let token = user.authentication.clientID!
            let name = user.profile.name!
            let email = user.profile.email!
            APIClient.social_network_login(token: token, name: name, email: email) { response in
                switch response.result {
                case .success(let user):
                    if response.response?.statusCode == 200{
                        if (user.data?.permissoes.contains("EXTERNO"))!{
                            UserDataDAO.save_social_net_user_data(userName: user.data!.name, userId: user.data!.id, userToken: user.data!.token, userEmail: user.data!.email)
                            self.view.hideToastActivity()
                            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                            let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
                            self.present(home_nav_vc, animated: false, completion: nil)
                        } else{
                            self.view.hideToastActivity()
                            self.view.makeToast("Usuário não habilitado para logar como externo.", duration: 1.0, position: .center)
                        }
                    }else{
                        self.view.hideToastActivity()
                        self.view.makeToast(user.errors?[0], duration: 1.0, position: .center)
                    }
                case .failure(let error):
                    self.view.hideToastActivity()
                    self.view.makeToast("Não foi possível realizar o login. Verifique sua conexão.", duration: 1.5, position: .center)
                    print(error)
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    @IBAction func login_with_facebook(_ sender: Any) {
        self.view.makeToastActivity(.center)
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController : self) { loginResult in
            switch loginResult {
            case .failed(_):
                self.view.hideToastActivity()
                self.view.makeToast("Erro ao carregar dados do Facebook.", duration: 1.5, position: .center)
                
            case .cancelled:
                self.view.hideToastActivity()

            case .success( _, _, _):
                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email,name"])) { httpResponse, result in
                    switch result {
                    case .success(let response):
                        let token = response.dictionaryValue!["id"]! as! String
                        let name  = response.dictionaryValue!["name"]! as! String
                        let email = response.dictionaryValue!["email"]! as! String
                        self.view.makeToastActivity(.center)
                        APIClient.social_network_login(token: token, name: name, email: email) { response in
                            switch response.result {
                            case .success(let user):
                                if response.response?.statusCode == 200{
                                    if (user.data?.permissoes.contains("EXTERNO"))!{
                                        UserDataDAO.save_social_net_user_data(userName: user.data!.name, userId: user.data!.id, userToken: user.data!.token, userEmail: user.data!.email)
                                        self.view.hideToastActivity()
                                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                        let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
                                        self.present(home_nav_vc, animated: false, completion: nil)
                                    } else{
                                        self.view.hideToastActivity()
                                        self.view.makeToast("Usuário não habilitado para logar como externo.", duration: 1.0, position: .center)
                                    }
                                }else{
                                    self.view.hideToastActivity()
                                    self.view.makeToast(user.errors?[0], duration: 1.0, position: .center)
                                }
                            case .failure(let error):
                                self.view.hideToastActivity()
                                self.view.makeToast("Não foi possível realizar o login. Verifique sua conexão.", duration: 1.5, position: .center)
                                print(error)
                            }
                        }
                    case .failed(let error):
                        self.view.hideToastActivity()
                        self.view.makeToast("Erro ao carregar dados do Facebook.", duration: 1.5, position: .center)
                        print("Graph Request Failed: \(error)")
                    }
                }
                connection.start()
            }
        }
    }
    
    //MARK: - Navigation methods
    @IBAction func create_new_account(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let create_account_vc:NewAccountViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "create_account_vc") as! NewAccountViewController
        self.navigationController?.pushViewController(create_account_vc, animated: true)
    }
    
    @IBAction func login_for_transire_employees(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let employee_login_vc:EmployeeLoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "employee_login_vc") as! EmployeeLoginViewController
        self.navigationController?.pushViewController(employee_login_vc, animated: true)
    }
    
    @IBAction func forgotten_password(_ sender: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let forgotten_password_vc:ForgottenPasswordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgotten_password_vc") as! ForgottenPasswordViewController
        self.navigationController?.pushViewController(forgotten_password_vc, animated: true)
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
