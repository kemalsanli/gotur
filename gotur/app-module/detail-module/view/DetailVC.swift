//
//  DetailVC.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var stepperStyling: UIView!
    @IBOutlet weak var bottomBarStyling: UIView!
    
    var selectedYemek:Yemek?
    var passingUsername:String?
    
    var DetailPresenter:ViewToPresenterDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        DetailRouter.createModule(ref: self)
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        DetailPresenter?.addToCart(object: selectedYemek!, username: passingUsername!, count: Int(stepperLabel.text!)!)
    }
    

    @IBAction func customStepper(_ sender: UIButton) {
        guard let unwrappedStepperLabel = stepperLabel.text else { return }
        guard let stepperValue = Int(unwrappedStepperLabel) else { return }
        guard let unwrappedSelectedYemek = selectedYemek else { return }
        guard let price = Int(unwrappedSelectedYemek.yemek_fiyat!) else { return }

        if sender.tag == 0 {
            if stepperValue > 1{
                let newValue = stepperValue - 1
                stepperLabel.text = "\(newValue)"
                let totalPrice = newValue * price
                updateLabelWithFade(totalPriceLabel, "₺\(totalPrice),00")
            }
        }else{
            let newValue = stepperValue + 1
            stepperLabel.text = "\(newValue)"
            let totalPrice = newValue * price
            updateLabelWithFade(totalPriceLabel, "₺\(totalPrice),00")
        }
    }
    
    

}

extension DetailVC:PresenterToViewDetailProtocol{
    func toggleDismiss() {
        _ = navigationController?.popViewController(animated: true)    }
    
}

//MARK: Style
extension DetailVC{
    func updateLabelWithFade(_ label:UILabel, _ text:String){
        label.alpha = 0
        label.text = text
        UIView.animate(withDuration: 0.3){
        label.alpha = 1.0
        }
    }
    
    func lessCurvedViews(_ view:UIView){
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
    }
    
    func setView(){
        guard let unwrappedSelectedYemek = selectedYemek else { return }
        lessCurvedViews(stepperStyling)
        lessCurvedViews(bottomBarStyling)
        stepperLabel.text = "1"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(unwrappedSelectedYemek.yemek_resim_adi!)"){
        imageView.kf.setImage(with: url)
        }
        titleLabel.text = unwrappedSelectedYemek.yemek_adi!
        priceLabel.text = "₺" + unwrappedSelectedYemek.yemek_fiyat! + ",00"
        totalPriceLabel.text = "₺" + unwrappedSelectedYemek.yemek_fiyat! + ",00"
    }
}
