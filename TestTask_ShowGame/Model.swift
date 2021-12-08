//
//  Model.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation

// MARK: - Game
struct Game: Codable {
    let tournament: Info?
    let date: String?
    let team1, team2: Info?
    let streamStatus: Int?

    enum CodingKeys: String, CodingKey {
        case tournament, date, team1, team2
        case streamStatus = "stream_status"
    }
}

// MARK: - Info
struct Info: Codable {
    let id: Int?
    let nameEng, nameRus: String?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nameEng = "name_eng"
        case nameRus = "name_rus"
        case score
    }
}

// MARK: - GameInfo
struct GameInfo: Codable {
    let name: String?
    let matchID, period, serverID: Int?
    let quality, folder, videoType, abc: String?
    let startMS, checksum, size: Int?
    let abcType: String?
    let duration, fps: Int?
    let urlRoot: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case matchID = "match_id"
        case period
        case serverID = "server_id"
        case quality, folder
        case videoType = "video_type"
        case abc
        case startMS = "start_ms"
        case checksum, size
        case abcType = "abc_type"
        case duration, fps
        case urlRoot = "url_root"
        case url
    }
}
