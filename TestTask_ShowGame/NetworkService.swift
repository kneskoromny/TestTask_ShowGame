//
//  NetworkService.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest(completion: @escaping (Game?) -> Void)
}

final class NetworkService {
    
    private let urlString1 = "https://api.instat.tv/test/data"
    private let urlString2 = "https://api.instat.tv/test/video-urls"
    
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Game?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print(#function, "Fetch error: \(error)")
                return
            }
            print(#function, "Response: \(response.statusCode)")
            let objects = self.parseJSON(from: data)
            
            DispatchQueue.main.async {
                completion(objects)
            }
        })
    }
    private func parseJSON(from data: Data?) -> Game? {
        guard let data = data else {
            print(#function, "No data to parse")
            return nil
        }
        do {
            let objects = try JSONDecoder().decode(Game.self, from: data)
            return objects
        } catch {
            print(#function, "Parsing error: \(error)")
        }
        return nil
    }
}

extension NetworkService: NetworkServiceProtocol {
    func makeRequest(completion: @escaping (Game?) -> Void) {

        let parameters1: [String: Any] = [
            "proc": "get_match_info",
            "params": [
                "_p_sport": 1,
                "_p_match_id": 1724836
                ]
        ]
        // отдает 8 ссылок
        let parameters2: [String: Any] = [
            "match_id": 1724836,
            "sport_id": 1
        ]
        
        guard let url = URL(string: urlString1) else {
            print(#function, "No url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters1, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
}
