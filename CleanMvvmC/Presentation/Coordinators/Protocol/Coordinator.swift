//
//  Coordinator.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
