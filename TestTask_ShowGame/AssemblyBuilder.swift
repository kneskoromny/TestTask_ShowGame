//
//  AssemblyBuilder.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func assembleInitialModule(with router: RouterProtocol) -> UIViewController
    
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func assembleInitialModule(with router: RouterProtocol) -> UIViewController {
        let viewController = MainViewController()
        let networkService = NetworkService()
        let dataFetcher = NetworkDataFetcher(networkService: networkService)
        let presenter = MainPresenter(view: viewController, dataFetcher: dataFetcher)
        viewController.presenter = presenter
        
        return viewController
    }
}
