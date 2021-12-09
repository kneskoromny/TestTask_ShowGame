//
//  APIManager.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import Foundation

struct APIManager {
    static func getStatURL() -> String {
        "https://api.instat.tv/test/data"
    }
    static func getVideosURL() -> String {
        "https://api.instat.tv/test/video-urls"
    }
    
    static func getStatParams() -> [String: Any] {
        [
            "proc": "get_match_info",
            "params": [
                "_p_sport": 1,
                "_p_match_id": 1724836
                ]
        ]
    }
    static func getVideosParams() -> [String: Any] {
        [
            "match_id": 1724836,
            "sport_id": 1
        ]
    }
}
