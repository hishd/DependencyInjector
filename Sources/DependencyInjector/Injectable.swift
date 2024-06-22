//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

@propertyWrapper
struct Injectable<T: InjectableDependency> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = Resolver.shared.resolve()
    }
}
