//
//  NetworkService.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest(completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService {
    
    private let urlString = "https://api.instat.tv/test/data"
    
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print(#function, "Fetch error: \(error?.localizedDescription)")
                return
            }
            print(#function, "Response: \(response.statusCode)")
            
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}

extension NetworkService: NetworkServiceProtocol {
    func makeRequest(completion: @escaping (Data?, Error?) -> Void) {
//        let proc =
//        let params = "{phone: \(phone), id: \(id)}"
//        let postData = parameters.data(using: .utf8)
        let parameters: [String: Any] = [
            "proc": "get_match_info",
            "params":
                [
                "_p_sport": 1,
                "_p_match_id": 1724836
                ]
        ]
        
        guard let url = URL(string: urlString) else {
            print(#function, "No url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
}
