//
//  MenuPresenter.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

final class MenuPresenter: ViewToPresenterMenuProtocol, InteractorToPresenterMenuProtocol{
    var MenuInteractor: PresenterToInteractorMenuProtocol?
    
    var MenuView: PresenterToViewMenuProtocol?
    
    func getCartTotal(username:String) {
        MenuInteractor?.getCartTotal(username: username)
    }
    
    func sendCartTotal(_ total: Int) {
        MenuView?.sendCartTotal(total)
    }
    
}
