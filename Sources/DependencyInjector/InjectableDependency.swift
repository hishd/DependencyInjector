//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

protocol InjectableDependency {
    associatedtype Dependency
    
    static var dependency: Dependency{get set}
}
