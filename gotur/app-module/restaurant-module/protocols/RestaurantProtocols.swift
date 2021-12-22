//
//  RestaurantProtocols.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation

protocol ViewToPresenterRestaurantProtocol {
    var RestaurantInteractor:PresenterToInteractorRestaurantProtocol? {get set}
    var RestaurantView:PresenterToViewRestaurantProtocol? {get set}
    
    func getCartTotal(username:String)
}

protocol PresenterToInteractorRestaurantProtocol {
    var RestaurantPresenter:InteractorToPresenterRestaurantProtocol? {get set}
    
    func getCartTotal(username kullaniciAdi:String)
}

protocol InteractorToPresenterRestaurantProtocol {
    func sendCartTotal(_ tutar:Int)
}

protocol PresenterToViewRestaurantProtocol {
    func sendCartTotal(_ tutar:Int)
}

protocol PresenterToRouterRestaurantProtocol {
    static func createModule(ref:RestaurantVC)
}
