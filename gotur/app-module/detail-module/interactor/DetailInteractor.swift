//
//  DetailInteractor.swift
//  gotur
//
//  Created by Kemal Sanlı on 14.12.2021.
//

import Foundation
import Alamofire

final class DetailInteractor:PresenterToInteractorDetailProtocol{
    var DetailPresenter: InteractorToPresenterDetailProtocol?
    
    func addToCart(object: Yemek, username: String, count:Int) {
        let params:Parameters = ["yemek_adi":object.yemek_adi!,"yemek_resim_adi":object.yemek_resim_adi!,"yemek_fiyat":Int(object.yemek_fiyat!)!,"yemek_siparis_adet":count,"kullanici_adi":username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).responseJSON{ [weak self] response in
            
            if let data = response.data {
                self?.DetailPresenter?.toggleDismiss()
            }
        }
    }
    
    
}
