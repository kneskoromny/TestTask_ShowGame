//
//  ViewController.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var networkService: NetworkServiceProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService = NetworkService()
        networkService.makeRequest { data, error in
            guard let data = data else { return }

            do {
                let objects = try JSONDecoder().decode([GameInfo].self, from: data)
                print("Objects: \(objects)")
            } catch {
                print("Parse error: \(error)")
            }
        }
    }


}

