//
//  LoginProtocols.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

protocol ViewToPresenterLoginProtocol {
    var LoginInteractor:PresenterToInteractorLoginProtocol? {get set}
    var LoginView:PresenterToViewLoginProtocol? {get set}
    
    func getYemekler()
}

protocol PresenterToInteractorLoginProtocol {
    var LoginPresenter:InteractorToPresenterLoginProtocol? {get set}
    
    func getYemekler()
}

protocol InteractorToPresenterLoginProtocol {
    func sendYemekler(_ Yemekler:Array<Yemek>)
}

protocol PresenterToViewLoginProtocol {
    func vieweVeriGonder(_ Yemekler:Array<Yemek>)
}

protocol PresenterToRouterLoginProtocol {
    static func createModule(ref:LoginVC)
}
