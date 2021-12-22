//
//  DetailRouter.swift
//  gotur
//
//  Created by Kemal Sanlı on 14.12.2021.
//

import Foundation

final class DetailRouter : PresenterToRouterDetailProtocol {
    static func createModule(ref: DetailVC) {
        let presenter : ViewToPresenterDetailProtocol & InteractorToPresenterDetailProtocol = DetailPresenter()
        
        //View controller
        ref.DetailPresenter = presenter
        
        //Presenter
        ref.DetailPresenter?.DetailInteractor = DetailInteractor()
        ref.DetailPresenter?.DetailView = ref
        
        //Interactor
        ref.DetailPresenter?.DetailInteractor?.DetailPresenter = presenter
    }
}
