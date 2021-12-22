//
//  CartPresenter.swift
//  gotur
//
//  Created by Kemal Sanlı on 15.12.2021.
//

import Foundation

final class CartPresenter:ViewToPresenterCartProtocol,InteractorToPresenterCartProtocol{
    
    
    
    var CartInteractor: PresenterToInteractorCartProtocol?
    
    var CartView: PresenterToViewCartProtocol?
    
    func setCart(cart: Array<SepetYemek>) {
        CartView?.setCart(cart: cart)
    }
    
    
    func getCart(username: String) {
        CartInteractor?.getCart(username: username)
    }
    
    
    func changeItemCount(count: Int, object: SepetYemek) {
        CartInteractor?.changeItemCount(count: count, object: object)
    }
    
    func deleteItem(object: SepetYemek, addItemSwitch: Bool = false, count: Int = 0) {
        CartInteractor?.deleteItem(object: object, addItemSwitch: addItemSwitch, count: count)
    }
    
    
    func wipeItems(object: Array<SepetYemek>) {
        CartInteractor?.wipeItems(object:object)
    }
    
}
