//
//  MainPresenter.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation
// MARK: - Protocol requirements
protocol MainPresenterProtocol {
    var stat: GameStat? { get }
    
    func fetchGameStat()
    func fetchGameVideos()
}

class MainPresenter {
    // MARK: - Dependencies
    weak var view: MainViewProtocol?
    var dataFetcher: DataFetcherProtocol?
    
    // MARK: - Data
    var gameStat: GameStat?
    var gameVideos: [GameVideo]?
    
    // MARK: - Initializers
    init(view: MainViewProtocol, dataFetcher: DataFetcherProtocol) {
        self.view = view
        self.dataFetcher = dataFetcher
    }
}
// MARK: - Protocol requirements implementation
extension MainPresenter: MainPresenterProtocol {
    var stat: GameStat? {
        gameStat
    }
    
    
    func fetchGameStat() {
        dataFetcher?.fetchGameStat { [weak self] gameStat in
            self?.gameStat = gameStat
            self?.view?.updateUI()
        }
    }
    
    func fetchGameVideos() {
        dataFetcher?.fetchVideos { [weak self] videos in
            self?.gameVideos = videos
        }
    }
}

