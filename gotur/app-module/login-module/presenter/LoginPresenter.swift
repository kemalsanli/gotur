//
//  LoginPresenter.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

final class LoginPresenter:ViewToPresenterLoginProtocol,InteractorToPresenterLoginProtocol{
    var LoginInteractor: PresenterToInteractorLoginProtocol?
    var LoginView: PresenterToViewLoginProtocol?
    
    func getYemekler() {
        LoginInteractor?.getYemekler()
    }
    
    func sendYemekler(_ Yemekler: Array<Yemek>) {
        LoginView?.vieweVeriGonder(Yemekler)
    }
    
}
