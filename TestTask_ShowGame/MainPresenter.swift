//
//  MainPresenter.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation
// MARK: - Protocol requirements
protocol MainPresenterProtocol {
    func fetchGameInfo()
}

class MainPresenter {
    // MARK: - Dependencies
    weak var view: MainViewProtocol?
    var networkService: NetworkServiceProtocol
    
    // MARK: - Data
    var gameStat: Game?
    var videos: [GameInfo]?
    
    // MARK: - Initializers
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
}
// MARK: - Protocol requirements implementation
extension MainPresenter: MainPresenterProtocol {
    func fetchGameInfo() {
        networkService.makeRequest(type: Game.self,
                                   with: APIManager.getStatURL(),
                                   params: APIManager.getStatParams()) { game in
            print(game)
        }
    }
}

