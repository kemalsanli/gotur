//
//  MenuRouter.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

final class MenuRouter : PresenterToRouterMenuProtocol {
    static func createModule(ref: MenuVC) {
        let presenter : ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol = MenuPresenter()
        
        //View controller
        ref.MenuPresenter = presenter
        
        //Presenter
        ref.MenuPresenter?.MenuInteractor = MenuInteractor()
        ref.MenuPresenter?.MenuView = ref
        
        //Interactor
        ref.MenuPresenter?.MenuInteractor?.MenuPresenter = presenter
    }
}
