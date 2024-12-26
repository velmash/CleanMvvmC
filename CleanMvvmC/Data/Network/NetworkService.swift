//
//  NetworkService.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import RxSwift

struct EmptyResponse: Decodable {
    // 빈 구조체로 Decodable 응답을 처리
}

protocol NetworkServiceType {
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> Observable<T>
    func requestWithEmptyResponse(_ endpoint: APIEndpoint) -> Observable<Void>
}

class NetworkService: NetworkServiceType {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> Observable<T> {
        // 기존 request 구현 유지
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let url = endpoint.url else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(NetworkError.networkError(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NetworkError.invalidResponse)
                    return
                }
                
                let successRange = 200..<300
                guard successRange.contains(httpResponse.statusCode) else {
                    observer.onError(NetworkError.serverError(httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(T.self, from: data)
                    observer.onNext(result)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.decodingError)
                }
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func requestWithEmptyResponse(_ endpoint: APIEndpoint) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let url = endpoint.url else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = self.session.dataTask(with: request) { _, response, error in
                if let error = error {
                    observer.onError(NetworkError.networkError(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NetworkError.invalidResponse)
                    return
                }
                
                let successRange = 200..<300
                guard successRange.contains(httpResponse.statusCode) else {
                    observer.onError(NetworkError.serverError(httpResponse.statusCode))
                    return
                }
                
                observer.onNext(())
                observer.onCompleted()
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
