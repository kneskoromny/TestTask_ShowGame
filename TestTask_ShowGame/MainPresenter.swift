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
    var videos: [GameVideo]? { get }
    var videosCount: Int { get }
    
    func fetchGameStat()
    func fetchGameVideos()
    
    func getVideoData(at indexPath: IndexPath) -> GameVideo
}

class MainPresenter {
    // MARK: - Dependencies
    weak var view: MainViewProtocol?
    var dataFetcher: DataFetcherProtocol?
    
    // MARK: - Data
    var gameStat: GameStat?
    var gameVideos: [GameVideo] = []
    
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
    var videos: [GameVideo]? {
        gameVideos
    }
    var videosCount: Int {
        gameVideos.count
    }
    
    
    func fetchGameStat() {
        dataFetcher?.fetchGameStat { [weak self] gameStat in
            self?.gameStat = gameStat
            self?.view?.updateLabels()
        }
    }
    func fetchGameVideos() {
        dataFetcher?.fetchVideos { [weak self] videos in
            if let videos = videos {
                self?.gameVideos = videos
                self?.view?.updateCollectionView()
            }
        }
    }
    
    func getVideoData(at indexPath: IndexPath) -> GameVideo {
        gameVideos[indexPath.row]
    }
}

