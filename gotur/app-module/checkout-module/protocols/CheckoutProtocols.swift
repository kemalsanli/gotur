//
//  CheckoutProtocols.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation

protocol ViewToPresenterCheckoutProtocol {
    var CheckoutInteractor:PresenterToInteractorCheckoutProtocol? {get set}
    var CheckoutView:PresenterToViewCheckoutProtocol? {get set}
    
    func wipeItems(object: Array<SepetYemek>)
    
}

protocol PresenterToInteractorCheckoutProtocol {
    var CheckoutPresenter:InteractorToPresenterCheckoutProtocol? {get set}
    
    func wipeItems(object: Array<SepetYemek>)
    
}

protocol InteractorToPresenterCheckoutProtocol {
    func toggleNavigation()
}

protocol PresenterToViewCheckoutProtocol {
    func toggleNavigation()
}

protocol PresenterToRouterCheckoutProtocol {
    static func createModule(ref:CheckoutVC)
}
