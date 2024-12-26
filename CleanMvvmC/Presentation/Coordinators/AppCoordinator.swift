//
//  AppCoordinator.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import UIKit

class AppCoordinator: Coordinator {
    let navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMain()
    }
    
    func finish() {
        // Clean up any resources if needed
    }
    
    private func showMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        addChildCoordinator(mainCoordinator)
        mainCoordinator.start()
    }
}
