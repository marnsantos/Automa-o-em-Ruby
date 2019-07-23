//
//  PaymentFeedbackViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 06/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class PaymentFeedbackViewController: UIViewController {
    
    @IBOutlet weak var lbPaymentStatus: UILabel!
    @IBOutlet weak var ivPaymentStatus: UIImageView!
    @IBOutlet weak var lbPaymentFeedback: UILabel!
    @IBOutlet weak var lbCancel: UILabel!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var vOrderNumber: UIView!
    var feedback:String!
    var idPedido:Int!

    //MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyShadowTo(view: vOrderNumber)
        ViewChanges.applyCornerRoundTo(button: btBack)
        if(feedback == "PAGAMENTO_APROVADO"){
            arr_cart.removeAll()
            lbPaymentStatus.text  = "Pedido efetuado com sucesso."
            ivPaymentStatus.image = UIImage.init(named: "done")
        }else if(feedback == "AGUARDANDO_PAGAMENTO"){
            arr_cart.removeAll()
            lbPaymentStatus.text  = "Aguardando pagamento."
            ivPaymentStatus.image = UIImage.init(named: "done")
            vOrderNumber.isHidden = true 
        }else if(feedback == "PEDIDO_CANCELADO"){
            lbPaymentStatus.text  = "Pedido cancelado."
            ivPaymentStatus.image = UIImage.init(named: "denied")
            lbPaymentFeedback.isHidden = true
            lbCancel.isHidden = true
            vOrderNumber.isHidden = true
        }else  if(feedback == "CARTAO_INVALIDO"){
            lbPaymentStatus.text  = "Cartão inválido."
            ivPaymentStatus.image = UIImage.init(named: "denied")
            lbPaymentFeedback.isHidden = true
            lbCancel.isHidden = true
            vOrderNumber.isHidden = true
        }else if(feedback == "NAO_AUTORIZADO"){
            lbPaymentStatus.text  = "Não autorizado."
            ivPaymentStatus.image = UIImage.init(named: "denied")
            lbPaymentFeedback.isHidden = true
            lbCancel.isHidden = true
            vOrderNumber.isHidden = true
        }else if(feedback == "ERROR_TIMEOUT"){
            lbPaymentStatus.text  = "Operação não finalizada."
            ivPaymentStatus.image = UIImage.init(named: "denied")
            lbPaymentFeedback.isHidden = true
            lbCancel.isHidden = true
            vOrderNumber.isHidden = true
        }
        lbPaymentFeedback.text  = "\(idPedido!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///MARK: - Navigation methods
    @IBAction func back_to_home(_ sender: Any) {
        if (lbPaymentFeedback.isHidden == true){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let home_nav_vc:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_nav_vc") as! UINavigationController
            self.present(home_nav_vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func go_to_cancel_politics(_ sender: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let cancellation_policy_vc:CancellationPolicyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cancellation_policy_vc") as! CancellationPolicyViewController
        self.present(cancellation_policy_vc, animated: false, completion: nil)
    }
    
}
