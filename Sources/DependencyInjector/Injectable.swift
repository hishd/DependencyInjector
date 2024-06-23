//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

@propertyWrapper
public struct Injectable<T> {
    private let keyPath: WritableKeyPath<InjectableValues, T>
    public var wrappedValue: T {
        get {
            InjectableValues[keyPath]
        }
        set {
            InjectableValues[keyPath] = newValue
        }
    }
    
    public init(_ keyPath: WritableKeyPath<InjectableValues, T>) {
        self.keyPath = keyPath
    }
}
