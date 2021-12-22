//
//  CartInteractor.swift
//  gotur
//
//  Created by Kemal Sanlı on 15.12.2021.
//

import Foundation
import Alamofire

final class CartInteractor: PresenterToInteractorCartProtocol{
    
    
    var CartPresenter: InteractorToPresenterCartProtocol?
    
    func getCart(username: String) {
        let params:Parameters = ["kullanici_adi":username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).responseJSON{ [weak self] response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    if json.success == 1 {
                        if let sepet = json.sepet_yemekler{
                            self?.CartPresenter?.setCart(cart: sepet)
                        }
                        
                    }
                }catch{
                    self?.CartPresenter?.setCart(cart:[SepetYemek]())
                    print("Normal ==>" + error.localizedDescription)
                }
            }
        }
    }
    
    func changeItemCount(count: Int, object: SepetYemek) {
        deleteItem(object: object,addItemSwitch: true,count: count)
    }
    
    
    func deleteItem(object: SepetYemek, addItemSwitch: Bool = false , count:Int = 0){
        let params:Parameters = ["sepet_yemek_id":Int(object.sepet_yemek_id!)!,"kullanici_adi":object.kullanici_adi!]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseJSON{ [weak self] response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(confirmResponse.self, from: data)
                    if json.success == 1 {
                        
                        if addItemSwitch { // If you send true, it calls addItem()
                            self?.addItem(object: object, count: count)
                        }else{
                            self?.getCart(username: object.kullanici_adi!)
                        }
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func addItem(object:SepetYemek,count:Int){
        let params:Parameters = ["yemek_adi":object.yemek_adi!,"yemek_resim_adi":object.yemek_resim_adi!,"yemek_fiyat":Int(object.yemek_fiyat!)!,"yemek_siparis_adet":count,"kullanici_adi":object.kullanici_adi!]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).responseJSON{ [weak self] response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(confirmResponse.self, from: data)
                    if json.success == 1 {
                        self?.getCart(username: object.kullanici_adi!)
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
    }
}
