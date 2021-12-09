//
//  MainPresenter.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation
// MARK: - Protocol requirements
protocol MainPresenterProtocol {
    func fetchGameStat()
    func fetchGameVideos()
}

class MainPresenter {
    // MARK: - Dependencies
    weak var view: MainViewProtocol?
    var dataFetcher: DataFetcherProtocol?
    
    // MARK: - Data
    var gameStat: GameStat?
    var videos: [GameVideo]?
    
    // MARK: - Initializers
    init(view: MainViewProtocol, dataFetcher: DataFetcherProtocol) {
        self.view = view
        self.dataFetcher = dataFetcher
    }
}
// MARK: - Protocol requirements implementation
extension MainPresenter: MainPresenterProtocol {
    
    func fetchGameStat() {
        dataFetcher?.fetchGameStat { game in
            print(game)
        }
    }
    
    func fetchGameVideos() {
        dataFetcher?.fetchVideos { videos in
            print(videos?.count)
        }
    }
}

