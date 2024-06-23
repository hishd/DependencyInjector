import XCTest
@testable import DependencyInjector

final class DependencyInjectorTests: XCTestCase {
    
    @Injectable(\.dataLogger) var logger: Logger 
    @Injectable(\.mockLogger) var mock: Logger
    
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}

struct DataLoggerDependency: InjectableDependency {
    static var dependency: Logger = DataLogger()
}

struct MockLoggerDependency: InjectableDependency {
    static var dependency: Logger = MockLogger()
}

extension InjectableValues {
    var dataLogger: Logger {
        get {
            Self[DataLoggerDependency.self]
        }
        set {
            Self[DataLoggerDependency.self] = newValue
        }
    }
    
    var mockLogger: Logger {
        get {
            Self[MockLoggerDependency.self]
        }
        set {
            Self[MockLoggerDependency.self] = newValue
        }
    }
}
