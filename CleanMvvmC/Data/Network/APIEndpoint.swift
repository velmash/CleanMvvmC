//
//  APIEndpoint.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import Foundation

enum APIEndpoint {
    case getUser(id: String)
    case createUser(UserDTO)
    case updateUser(id: String, UserDTO)
    case deleteUser(id: String)
    
    var baseURL: String {
        return "https://666abd117013419182d0b895.mockapi.io/yhc/v1"
    }
    
    var path: String {
        switch self {
        case .getUser(let id):
            return "/User/\(id)"
        case .createUser:
            return "/User"
        case .updateUser(let id, _):
            return "/User/\(id)"
        case .deleteUser(let id):
            return "/User/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getUser:
            return "GET"
        case .createUser:
            return "POST"
        case .updateUser:
            return "PUT"
        case .deleteUser:
            return "DELETE"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
