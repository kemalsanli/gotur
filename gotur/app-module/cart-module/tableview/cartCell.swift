//
//  cartCell.swift
//  gotur
//
//  Created by Kemal Sanlı on 14.12.2021.
//

import UIKit
import SwiftUI

protocol cartCellToViewProtocol{
    func deleteSiparis(indexPath:IndexPath)
    func changeItemCount(stepper:Int,indexPath:IndexPath)
}

final class cartCell: UITableViewCell {
    
    var CartVC:cartCellToViewProtocol?
    var indexPath:IndexPath?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stepperStyling: UIView!
    @IBOutlet weak var stepperLabel: UILabel!
    
    
    @IBOutlet weak var stylingStepperBackground: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        smoothCorners(stepperStyling)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func customStepper(_ sender: UIButton) {
        guard let stepper = Int(stepperLabel.text!) else { return }
        if sender.tag == 0 { // "-"
            if stepper == 1 {
                CartVC?.deleteSiparis(indexPath: indexPath!)
            }else if stepper > 1 {
                let result = stepper - 1
                stepperLabel.text = "\(result)"
                CartVC?.changeItemCount(stepper: result, indexPath: indexPath!)
            }
        }else if sender.tag == 1 { // "+"
            let result = stepper + 1
            stepperLabel.text = "\(result)"
            CartVC?.changeItemCount(stepper: result, indexPath: indexPath!)
        }
        
    }
    
    func setCell(object:SepetYemek){
        titleLabel.text = object.yemek_adi!
        priceLabel.text = "₺\(object.yemek_fiyat!),00"
        stepperLabel.text = object.yemek_siparis_adet!
    }
    
    func smoothCorners(_ view:UIView){
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
    }
    

}
