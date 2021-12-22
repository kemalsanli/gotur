//
//  DetailProtocols.swift
//  gotur
//
//  Created by Kemal Sanlı on 14.12.2021.
//

import Foundation

protocol ViewToPresenterDetailProtocol {
    var DetailInteractor:PresenterToInteractorDetailProtocol? {get set}
    var DetailView:PresenterToViewDetailProtocol? {get set}
    
    func addToCart(object:Yemek,username:String,count:Int)
}

protocol PresenterToInteractorDetailProtocol {
    var DetailPresenter:InteractorToPresenterDetailProtocol? {get set}
    
    func addToCart(object:Yemek,username:String,count:Int)
}

protocol InteractorToPresenterDetailProtocol {
    func toggleDismiss()
}

protocol PresenterToViewDetailProtocol {
    func toggleDismiss()
}

protocol PresenterToRouterDetailProtocol {
    static func createModule(ref:DetailVC)
}
