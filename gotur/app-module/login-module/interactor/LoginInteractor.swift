//
//  LoginInteractor.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation
import Alamofire

final class LoginInteractor:PresenterToInteractorLoginProtocol{
    var LoginPresenter: InteractorToPresenterLoginProtocol?

    func getYemekler() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).responseJSON{ [weak self] response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerResponse.self, from: data)
                    var list = [Yemek]()
                    
                    if let gelenListe = cevap.yemekler {
                        list = gelenListe
                    }
                    self?.LoginPresenter?.sendYemekler(list)
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}


