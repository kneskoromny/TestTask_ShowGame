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
