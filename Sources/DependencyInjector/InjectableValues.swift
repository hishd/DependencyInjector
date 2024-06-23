//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

struct InjectableValues {
    
    private static var current: InjectableValues = InjectableValues()
    
    static subscript<T>(keyPath: WritableKeyPath<InjectableValues, T>) -> T {
        get {
            current[keyPath: keyPath]
        } set {
            current[keyPath: keyPath] = newValue
        }
    }
    
    static subscript<T: InjectableDependency>(type: T.Type) -> T.Dependency {
        get {
            return type.dependency
        }
        set {
            type.dependency = newValue
        }
    }
}
