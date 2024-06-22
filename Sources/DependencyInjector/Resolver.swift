//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

public protocol InjectableDependency {}

public class Resolver {
    
    public static let shared: Resolver = Resolver()
    private var storage: [String: InjectableDependency] = .init()
    
    public func add<T: InjectableDependency>(injectable: T) {
        let key = String(reflecting: T.self)
        storage.updateValue(injectable, forKey: key)
    }
    
    public func resolve<T: InjectableDependency>() -> T {
        let key = String(reflecting: T.self)
        
        guard let resource = storage[key] as? T else {
            fatalError("Could not find dependency of type \(T.self)")
        }
        
        return resource
    }
}
