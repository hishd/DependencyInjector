//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

public struct InjectableValues {
    
    private static var current: InjectableValues = InjectableValues()
    
    public static subscript<T>(keyPath: KeyPath<InjectableValues, T>) -> T {
        get {
            current[keyPath: keyPath]
        } set {
            if let keyPath = keyPath as? WritableKeyPath<InjectableValues, T> {
                current[keyPath: keyPath] = newValue
            } else {
                fatalError("KeyPath is not writable")
            }
        }
    }
    
    public static subscript<T: InjectableDependency>(type: T.Type) -> T.Dependency {
        get {
            return type.dependency
        }
        set {
            type.dependency = newValue
        }
    }
}
