//
//  CartRouter.swift
//  gotur
//
//  Created by Kemal Sanlı on 15.12.2021.
//

import Foundation

final class CartRouter : PresenterToRouterCartProtocol {
    static func createModule(ref: CartVC) {
        let presenter : ViewToPresenterCartProtocol & InteractorToPresenterCartProtocol = CartPresenter()
        
        //View controller
        ref.CartPresenter = presenter
        
        //Presenter
        ref.CartPresenter?.CartInteractor = CartInteractor()
        ref.CartPresenter?.CartView = ref
        
        //Interactor
        ref.CartPresenter?.CartInteractor?.CartPresenter = presenter
    }
}
