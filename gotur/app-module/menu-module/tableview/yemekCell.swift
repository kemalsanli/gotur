//
//  yemekCell.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import UIKit
import Kingfisher

final class yemekCell: UITableViewCell {

    @IBOutlet weak var yemekImage: UIImageView!
    @IBOutlet weak var yemekSubtitleLabel: UILabel!
    @IBOutlet weak var yemekPriceLabel: UILabel!
    @IBOutlet weak var yemekTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ object:Yemek){
        if let yemekAdi = object.yemek_adi, let yemekFiyat = object.yemek_fiyat, let yemekResimAdi = object.yemek_resim_adi {
            yemekTitleLabel.text = yemekAdi
            yemekPriceLabel.text = "₺" +  yemekFiyat + ",00"
            setImageWithParameter(yemekResimAdi)
        }
        
    }
    
    func setImageWithParameter(_ imageurl:String){
                guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageurl)") else { return }
            yemekImage.kf.setImage(with: url)
    }

}
