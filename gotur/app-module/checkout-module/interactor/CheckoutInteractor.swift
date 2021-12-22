//
//  CheckoutInteractor.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation
import Alamofire

final class CheckoutInteractor: PresenterToInteractorCheckoutProtocol{
    
    
    var CheckoutPresenter: InteractorToPresenterCheckoutProtocol?
    
    
    
    
    
    func deleteItem(object: SepetYemek){
        let params:Parameters = ["sepet_yemek_id":Int(object.sepet_yemek_id!)!,"kullanici_adi":object.kullanici_adi!]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseJSON{ [weak self] response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(confirmResponse.self, from: data)
                    if json.success == 1 {
                                                
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func wipeItems(object: Array<SepetYemek>) {
        for yemek in object{
            DispatchQueue.main.async { [weak self] in
                self?.deleteItem(object: yemek)
            }
        }
        CheckoutPresenter?.toggleNavigation()
    }
}
