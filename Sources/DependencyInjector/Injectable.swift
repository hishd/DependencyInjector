//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

@propertyWrapper
struct Injectable<T> {
    private let keyPath: WritableKeyPath<InjectableValues, T>
    var wrappedValue: T {
        get {
            InjectableValues[keyPath]
        }
        set {
            InjectableValues[keyPath] = newValue
        }
    }
    
    init(_ keyPath: WritableKeyPath<InjectableValues, T>) {
        self.keyPath = keyPath
    }
}
