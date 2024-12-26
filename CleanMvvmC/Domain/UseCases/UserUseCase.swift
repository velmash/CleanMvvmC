//
//  UserUseCase.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import Foundation
import RxSwift

protocol UserUseCase {
    func getUser(by id: String) -> Observable<User>
    func saveUser(_ user: User) -> Observable<Void>
}

class UserUseCaseImpl: UserUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func getUser(by id: String) -> Observable<User> {
        return repository.getUser(by: id)
    }
    
    func saveUser(_ user: User) -> Observable<Void> {
        return repository.saveUser(user)
    }
}
