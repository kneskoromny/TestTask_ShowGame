//
//  NetworkDataFetcher.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import Foundation

// MARK: - Protocol requirements
protocol DataFetcherProtocol {
    func fetchGameStat(completion: @escaping (GameStat?) -> Void)
    func fetchVideos(completion: @escaping ([GameVideo]?) -> Void)
}

final class NetworkDataFetcher {
    // MARK: - Dependencies
    var networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Protocol requirements implementation
extension NetworkDataFetcher: DataFetcherProtocol {
    func fetchGameStat(completion: @escaping (GameStat?) -> Void) {
        
        networkService.makeRequest(type: GameStat.self,
                                   with: APIManager.getStatURL(),
                                   params: APIManager.getStatParams(),
                                   completion: completion)
    }
    
    func fetchVideos(completion: @escaping ([GameVideo]?) -> Void)  {
        
        networkService.makeRequest(type: [GameVideo].self,
                                   with: APIManager.getVideosURL(),
                                   params: APIManager.getVideosParams(),
                                   completion: completion)
    }
}
