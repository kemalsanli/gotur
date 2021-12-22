//
//  RestaurantRouter.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation

final class RestaurantRouter : PresenterToRouterRestaurantProtocol {
    static func createModule(ref: RestaurantVC) {
        let presenter : ViewToPresenterRestaurantProtocol & InteractorToPresenterRestaurantProtocol = RestaurantPresenter()
        
        //View controller
        ref.RestaurantPresenter = presenter
        
        //Presenter
        ref.RestaurantPresenter?.RestaurantInteractor = RestaurantInteractor()
        ref.RestaurantPresenter?.RestaurantView = ref
        
        //Interactor
        ref.RestaurantPresenter?.RestaurantInteractor?.RestaurantPresenter = presenter
    }
}
