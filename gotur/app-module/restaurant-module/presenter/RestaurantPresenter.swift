//
//  RestaurantPresenter.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation

final class RestaurantPresenter: ViewToPresenterRestaurantProtocol, InteractorToPresenterRestaurantProtocol{
    var RestaurantInteractor: PresenterToInteractorRestaurantProtocol?
    
    var RestaurantView: PresenterToViewRestaurantProtocol?
    
    func getCartTotal(username:String) {
        RestaurantInteractor?.getCartTotal(username: username)
    }
    
    func sendCartTotal(_ total: Int) {
        RestaurantView?.sendCartTotal(total)
    }
    
}
