//
//  UserDTO.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import Foundation

struct UserDTO: Codable {
    let name: String
    let age: Int
    
    func toEntity(id: String) -> User {
        return User(id: id, name: name, age: age)
    }
}
