//
//  LoginRouter.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

final class LoginRouter : PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginVC) {
        let presenter : ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresenter()
        
        //View controller
        ref.LoginPresenter = presenter
        
        //Presenter
        ref.LoginPresenter?.LoginInteractor = LoginInteractor()
        ref.LoginPresenter?.LoginView = ref
        
        //Interactor
        ref.LoginPresenter?.LoginInteractor?.LoginPresenter = presenter
    }
}
