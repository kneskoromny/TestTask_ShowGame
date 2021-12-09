//
//  Router.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import Foundation
import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get }
    var assemblyBulder: AssemblyBuilderProtocol? { get }
    func showInitial()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBulder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBulder = assemblyBuilder
    }
    
    func showInitial() {
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            guard let initialViewController = assemblyBulder?.assembleInitialModule(with: self) else { return }
            initialViewController.navigationItem.title = "Инфо"
            navigationController.viewControllers = [initialViewController]
        }
    }
}

