//
//  NetworkDataFetcher.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import Foundation

enum URLString: String {
    case stat = "https://api.instat.tv/test/data"
    case videos = "https://api.instat.tv/test/video-urls"
}

// MARK: - Protocol requirements
protocol DataFetcherProtocol {
    func fetchGameStat(completion: @escaping (Game?) -> Void)
    func fetchVideos()
}

final class NetworkDataFetcher {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Protocol requirements implementation
extension NetworkDataFetcher: DataFetcherProtocol {
    func fetchGameStat(completion: @escaping (Game?) -> Void) {
        networkService.makeRequest(type: Game.self,
                                   with: APIManager.getStatURL(),
                                   params: APIManager.getStatParams(),
                                   completion: completion)
    }
    
    func fetchVideos() {
        print(2)
    }
}
