//
//  CheckoutPresenter.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation

final class CheckoutPresenter:ViewToPresenterCheckoutProtocol,InteractorToPresenterCheckoutProtocol{
    
    
       
    var CheckoutInteractor: PresenterToInteractorCheckoutProtocol?
    
    var CheckoutView: PresenterToViewCheckoutProtocol?
    

    
    func wipeItems(object: Array<SepetYemek>) {
        CheckoutInteractor?.wipeItems(object:object)
    }
    func toggleNavigation() {
        CheckoutView?.toggleNavigation()
    }
    
}
