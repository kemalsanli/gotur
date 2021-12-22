//
//  MenuProtocols.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

protocol ViewToPresenterMenuProtocol {
    var MenuInteractor:PresenterToInteractorMenuProtocol? {get set}
    var MenuView:PresenterToViewMenuProtocol? {get set}
    
    func getCartTotal(username:String)
}

protocol PresenterToInteractorMenuProtocol {
    var MenuPresenter:InteractorToPresenterMenuProtocol? {get set}
    
    func getCartTotal(username:String)
}

protocol InteractorToPresenterMenuProtocol {
    func sendCartTotal(_ total:Int)
}

protocol PresenterToViewMenuProtocol {
    func sendCartTotal(_ total:Int)
}

protocol PresenterToRouterMenuProtocol {
    static func createModule(ref:MenuVC)
}
