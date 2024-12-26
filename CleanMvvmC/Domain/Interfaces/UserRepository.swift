//
//  UserRepository.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import Foundation
import RxSwift

protocol UserRepository {
    func getUser(by id: String) -> Observable<User>
    func saveUser(_ user: User) -> Observable<Void>
}
