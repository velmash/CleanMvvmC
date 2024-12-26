//
//  ViewModelType.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
