//
//  File.swift
//  
//
//  Created by Hishara Dilshan on 2024-06-23.
//

import Foundation

protocol Logger {
    func logData(data: String)
    func logError(error: Error)
}

class DataLogger: Logger {
    func logData(data: String) {
        print(data)
    }
    
    func logError(error: any Error) {
        print(error)
    }
}

class MockLogger: Logger {
    func logData(data: String) {
        print(data)
    }
    
    func logError(error: any Error) {
        print(error)
    }
}
