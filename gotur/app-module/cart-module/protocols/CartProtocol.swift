//
//  CartProtocol.swift
//  gotur
//
//  Created by Kemal Sanlı on 15.12.2021.
//

import Foundation

protocol ViewToPresenterCartProtocol {
    var CartInteractor:PresenterToInteractorCartProtocol? {get set}
    var CartView:PresenterToViewCartProtocol? {get set}
    
    func getCart(username:String)
    func changeItemCount(count:Int,object:SepetYemek)
    func deleteItem(object: SepetYemek, addItemSwitch: Bool , count:Int)
    func wipeItems(object: Array<SepetYemek>)
}

protocol PresenterToInteractorCartProtocol {
    var CartPresenter:InteractorToPresenterCartProtocol? {get set}
    
    func getCart(username:String)
    func changeItemCount(count:Int,object:SepetYemek)
    func deleteItem(object: SepetYemek, addItemSwitch: Bool , count:Int)
    func wipeItems(object: Array<SepetYemek>)
}

protocol InteractorToPresenterCartProtocol {
    func setCart(cart:Array<SepetYemek>)
}

protocol PresenterToViewCartProtocol {
    func setCart(cart:Array<SepetYemek>)
}

protocol PresenterToRouterCartProtocol {
    static func createModule(ref:CartVC)
}
