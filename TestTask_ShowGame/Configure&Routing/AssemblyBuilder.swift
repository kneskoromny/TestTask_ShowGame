//
//  AssemblyBuilder.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func assembleInitialModule(with router: RouterProtocol) -> UIViewController
    
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func assembleInitialModule(with router: RouterProtocol) -> UIViewController {
        let viewController = MainViewController()
        let networkService = NetworkService()
        let dataFetcher = NetworkDataFetcher(networkService: networkService)
        let presenter = MainPresenter(view: viewController, dataFetcher: dataFetcher)
        viewController.presenter = presenter
        
        return viewController
    }
}
