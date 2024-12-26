//
//  APIResponse.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(NetworkError)
}
