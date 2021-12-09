//
//  MainPresenter.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation
import AVFoundation

// MARK: - Protocol requirements
protocol MainPresenterProtocol {
    var stat: GameStat? { get }
    var videos: [GameVideo]? { get }
    var videosCount: Int { get }
    
    func fetchGameStat()
    func fetchGameVideos()
    
    func getVideoData(at indexPath: IndexPath) -> GameVideo
    func preparePath(at indexPath: IndexPath)
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
    
    func getURL(at index: Int) -> URL? {
        guard let strURL = gameVideos[index].url else { return nil }
        return URL(string: strURL)
    }
    
//    func createPlayer(with url: URL?) {
//        guard let url = url else { return }
//
//        //2. Create AVPlayer object
//        let asset = AVAsset(url: url)
//        let playerItem = AVPlayerItem(asset: asset)
//        let player = AVPlayer(playerItem: playerItem)
//
//        //3. Create AVPlayerLayer object
//        let playerLayer = AVPlayerLayer(player: player)
//        let videoViewFrame = view?.getFrame()
//        playerLayer.frame = videoViewFrame!
//        playerLayer.videoGravity = .resizeAspect
//
//        //4. Add playerLayer to view's layer
//        view?.addLayer(playerLayer)
//
//        //5. Play Video
//        player.play()
//
//    }
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
    func preparePath(at indexPath: IndexPath) {
        let url = getURL(at: indexPath.row)
        view?.showVideo(from: url)
    }
}

