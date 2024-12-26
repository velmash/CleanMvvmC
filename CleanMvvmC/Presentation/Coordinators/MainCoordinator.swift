//
//  MainCoordinator.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import UIKit

class MainCoordinator: Coordinator {
    let navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let userUseCase: UserUseCase
    
    init(navigationController: UINavigationController,
         userAPIService: UserAPIServiceType = UserAPIService()) {
        self.navigationController = navigationController
        let repository = UserRepositoryImpl(
            apiService: userAPIService,
            dbService: CoreDataService()
        )
        self.userUseCase = UserUseCaseImpl(repository: repository)
    }
    
    func start() {
        showMainViewController()
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    private func showMainViewController() {
        let viewModel = MainViewModel(coordinator: self, userUseCase: userUseCase)
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
//    func showDetail(with user: User) {
//        let detailCoordinator = DetailCoordinator(
//            navigationController: navigationController,
//            user: user
//        )
//        addChildCoordinator(detailCoordinator)
//        detailCoordinator.start()
//    }
}
