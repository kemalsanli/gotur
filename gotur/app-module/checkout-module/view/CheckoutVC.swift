//
//  CheckoutVC.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import UIKit
import SwiftUI

final class CheckoutVC: UIViewController {
    
    var totalPrice:String?
    var objectListToDelete:Array<SepetYemek>?
    @IBOutlet weak var confirmPaymentButton: UIButton!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var stylingHeadBar: UIView!
    @IBOutlet weak var stylingBottomView: UIView!
    
    var CheckoutPresenter:ViewToPresenterCheckoutProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        stylingHeadBar.layer.cornerRadius = 29
        stylingHeadBar.layer.masksToBounds = true
        stylingBottomView.layer.cornerRadius = 5
        stylingBottomView.layer.masksToBounds = true
        
        CheckoutRouter.createModule(ref: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        totalPriceLabel.text = totalPrice!
        
    }
    
    @IBAction func confirmPaymentButtonClicked(_ sender: Any) {
        guard let objectList = objectListToDelete else { return }
        CheckoutPresenter?.wipeItems(object:objectList)
        confirmPaymentButton.setTitle("Sipariş Veriliyor...", for: .normal)
    }
}

extension CheckoutVC:PresenterToViewCheckoutProtocol{
    func toggleNavigation() {
        let alert = UIAlertController(title: "Siparişiniz Onaylandı 😊", message: "Restoran Personeline Yemek Ismarladığınız İçin Teşekkürler", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Tamam", style: .default){ [weak self] action in
            _ = self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(tamamAction)
        present(alert, animated: true, completion: nil)
        
    }
}
