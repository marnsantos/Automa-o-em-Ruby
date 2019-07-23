//
//  ContactUsViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 08/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func contact_via_call(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(contactPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func contact_via_email(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    @IBAction func go_to_website(_ sender: Any) {
         let url = URL(string: "http://www.pescattu.com")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([contactEmailAddress])
        composeVC.setSubject("Aplicativo Pescattu")
        composeVC.setMessageBody("", isHTML: false)
        return composeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Erro", message: "Não foi possível enviar e-mail.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
}
