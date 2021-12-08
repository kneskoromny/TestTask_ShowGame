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
        networkService.makeRequest { response, error in
            print("response: \(response.statusCode)")
        }
    }


}

