//
//  RestaurantInteractor.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation
import Alamofire

final class RestaurantInteractor: PresenterToInteractorRestaurantProtocol{
    var RestaurantPresenter: InteractorToPresenterRestaurantProtocol?
    
    func getCartTotal(username kullaniciAdi:String) {
        let params:Parameters = ["kullanici_adi": kullaniciAdi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).responseJSON{ [weak self] response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    if json.success == 1 {
                        
                        var tutar = 0
                        
                        if let sepet = json.sepet_yemekler{
                            for urun in sepet{
                                let fiyat = Int(urun.yemek_fiyat!)!
                                let adet = Int(urun.yemek_siparis_adet!)!
                                tutar = tutar + (fiyat * adet)
                            }
                        }
                        self?.RestaurantPresenter?.sendCartTotal(tutar)
                    }
                }catch{
                    self?.RestaurantPresenter?.sendCartTotal(0)
                    print("Normal ==>" + error.localizedDescription)
                }
            }
        }
    }
    
}
