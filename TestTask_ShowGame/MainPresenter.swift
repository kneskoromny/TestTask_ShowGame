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
    var dataFetcher: DataFetcherProtocol?
    
    // MARK: - Data
    var gameStat: Game?
    var videos: [GameInfo]?
    
    // MARK: - Initializers
    init(view: MainViewProtocol, dataFetcher: DataFetcherProtocol) {
        self.view = view
        self.dataFetcher = dataFetcher
    }
}
// MARK: - Protocol requirements implementation
extension MainPresenter: MainPresenterProtocol {
    func fetchGameInfo() {
        dataFetcher?.fetchGameStat(completion: { game in
            print(game)
        })
    }
}

