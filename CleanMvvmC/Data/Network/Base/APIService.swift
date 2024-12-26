//
//  APIService.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import RxSwift

protocol APIServiceType {
    var networkService: NetworkServiceType { get }
}

class BaseAPIService: APIServiceType {
    let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
}
