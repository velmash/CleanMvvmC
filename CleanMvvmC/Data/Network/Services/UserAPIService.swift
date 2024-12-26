//
//  UserAPIService.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import RxSwift

protocol UserAPIServiceType {
    func getUser(by id: String) -> Observable<APIResult<UserDTO>>
    func createUser(_ user: UserDTO) -> Observable<APIResult<UserDTO>>
    func updateUser(id: String, user: UserDTO) -> Observable<APIResult<UserDTO>>
    func deleteUser(id: String) -> Observable<APIResult<Void>>
}

class UserAPIService: BaseAPIService, UserAPIServiceType {
    func getUser(by id: String) -> Observable<APIResult<UserDTO>> {
        return networkService.request(.getUser(id: id))
            .map { APIResult.success($0) }
            .catch { error in
                .just(.failure(error as? NetworkError ?? .unknown))
            }
    }
    
    func createUser(_ user: UserDTO) -> Observable<APIResult<UserDTO>> {
        return networkService.request(.createUser(user))
            .map { APIResult.success($0) }
            .catch { error in
                .just(.failure(error as? NetworkError ?? .unknown))
            }
    }
    
    func updateUser(id: String, user: UserDTO) -> Observable<APIResult<UserDTO>> {
        return networkService.request(.updateUser(id: id, user))
            .map { APIResult.success($0) }
            .catch { error in
                .just(.failure(error as? NetworkError ?? .unknown))
            }
    }
    
    func deleteUser(id: String) -> Observable<APIResult<Void>> {
        return networkService.requestWithEmptyResponse(.deleteUser(id: id))
            .map { APIResult.success(()) }
            .catch { error in
                .just(.failure(error as? NetworkError ?? .unknown))
            }
    }
}
