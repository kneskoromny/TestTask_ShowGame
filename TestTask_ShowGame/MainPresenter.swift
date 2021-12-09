//
//  MainPresenter.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation

protocol MainPresenterProtocol {
    
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var networkService: NetworkServiceProtocol
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
}

extension MainPresenter: MainPresenterProtocol {
    
}
