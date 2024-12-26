//
//  MainViewModel.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import RxSwift

class MainViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private let userUseCase: UserUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let userButtonTap: Observable<Void>
    }
    
    struct Output {
        let user: Observable<User>
        let error: Observable<Error>
    }
    
    init(coordinator: MainCoordinator?, userUseCase: UserUseCase) {
        self.coordinator = coordinator
        self.userUseCase = userUseCase
    }
    
    func transform(input: Input) -> Output {
        let errorTracker = PublishSubject<Error>()
        
        let user = input.userButtonTap
            .flatMapLatest { [unowned self] _ in
                return self.userUseCase.getUser(by: "4")
                    .do(onNext: { [weak self] user in
//                        self?.coordinator?.showDetail(with: user)
                    })
                    .catch { error in
                        errorTracker.onNext(error)
                        return .empty()
                    }
            }
        
        return Output(
            user: user,
            error: errorTracker.asObservable()
        )
    }
}
