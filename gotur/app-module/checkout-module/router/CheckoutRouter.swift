//
//  CheckoutRouter.swift
//  gotur
//
//  Created by Kemal Sanlı on 18.12.2021.
//

import Foundation

final class CheckoutRouter : PresenterToRouterCheckoutProtocol {
    static func createModule(ref: CheckoutVC) {
        let presenter : ViewToPresenterCheckoutProtocol & InteractorToPresenterCheckoutProtocol = CheckoutPresenter()
        
        //View controller
        ref.CheckoutPresenter = presenter
        
        //Presenter
        ref.CheckoutPresenter?.CheckoutInteractor = CheckoutInteractor()
        ref.CheckoutPresenter?.CheckoutView = ref
        
        //Interactor
        ref.CheckoutPresenter?.CheckoutInteractor?.CheckoutPresenter = presenter
    }
}
