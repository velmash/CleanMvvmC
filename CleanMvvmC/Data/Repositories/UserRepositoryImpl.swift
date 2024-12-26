//
//  U serRepositoryImpl.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import RxSwift

class UserRepositoryImpl: UserRepository {
    private let apiService: UserAPIServiceType
    private let dbService: CoreDataService
    
    init(apiService: UserAPIServiceType = UserAPIService(),
         dbService: CoreDataService = CoreDataService()) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func getUser(by id: String) -> Observable<User> {
        return dbService.getUser(by: id)
            .catch { _ in
                return self.apiService.getUser(by: id)
                    .flatMap { result -> Observable<User> in
                        switch result {
                        case .success(let dto):
                            let user = dto.toEntity(id: id)
                            return .just(user)
                        case .failure(let error):
                            return .error(error)
                        }
                    }
                    .do(onNext: { user in
                        _ = self.dbService.saveUser(user)
                    })
            }
    }
    
    func saveUser(_ user: User) -> Observable<Void> {
        let dto = UserDTO(name: user.name, age: user.age)
        return apiService.createUser(dto)
            .flatMap { result -> Observable<Void> in
                switch result {
                case .success:
                    return self.dbService.saveUser(user)
                case .failure(let error):
                    return .error(error)
                }
            }
    }
}
