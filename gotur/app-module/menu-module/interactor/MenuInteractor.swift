//
//  MenuInteractor.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation
import Alamofire

final class MenuInteractor: PresenterToInteractorMenuProtocol{
    var MenuPresenter: InteractorToPresenterMenuProtocol?
    
    func getCartTotal(username:String) {
        let params:Parameters = ["kullanici_adi":username]
        
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
                        self?.MenuPresenter?.sendCartTotal(tutar)
                    }
                }catch{
                    self?.MenuPresenter?.sendCartTotal(0)
                    print("Normal ==>" + error.localizedDescription)
                }
            }
        }
    }
    
}
