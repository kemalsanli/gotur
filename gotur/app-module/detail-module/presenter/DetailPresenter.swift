//
//  DetailPresenter.swift
//  gotur
//
//  Created by Kemal Sanlı on 14.12.2021.
//

import Foundation

final class DetailPresenter:ViewToPresenterDetailProtocol,InteractorToPresenterDetailProtocol{
    var DetailInteractor: PresenterToInteractorDetailProtocol?
    
    var DetailView: PresenterToViewDetailProtocol?
    
    func addToCart(object: Yemek, username: String,count:Int) {
        DetailInteractor?.addToCart(object: object, username: username, count: count)
    }
    
    func toggleDismiss() {
        DetailView?.toggleDismiss()
    }
    
    
}
