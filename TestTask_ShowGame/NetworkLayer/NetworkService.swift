//
//  NetworkService.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import Foundation

// MARK: - Protocol requirements
protocol NetworkServiceProtocol {
    func makeRequest<T: Decodable>(type: T.Type, with url: String,
                     params: [String: Any],
                     completion: @escaping (T?) -> Void)
}

final class NetworkService {
    
    // MARK: - Launch session
    private func createDataTask<T: Decodable>(type: T.Type,
                                              from request: URLRequest,
                                              completion: @escaping (T?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print(#function, "Fetch error: \(String(describing: error))")
                return
            }
            print(#function, "Response: \(response.statusCode)")
            let objects = self.parseJSON(type: type, from: data)
            
            DispatchQueue.main.async {
                completion(objects)
            }
        })
    }
    // MARK: - Parse data
    private func parseJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        guard let data = data else {
            print(#function, "No data to parse")
            return nil
        }
        do {
            let objects = try JSONDecoder().decode(T.self, from: data)
            return objects
        } catch {
            print(#function, "Parsing error: \(error)")
        }
        return nil
    }
}
// MARK: - Protocol requirements implementation
extension NetworkService: NetworkServiceProtocol {
    func makeRequest<T>(type: T.Type,
                        with url: String,
                        params: [String : Any],
                        completion: @escaping (T?) -> Void) where T : Decodable {
        
        guard let url = URL(string: url) else {
            print(#function, "No url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params,
                                                       options: .prettyPrinted)
   
        let task = createDataTask(type: type, from: request, completion: completion)
        task.resume()
    }
}
