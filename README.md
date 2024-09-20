# DependencyInjector

**DependencyInjector** is a lightweight Swift library that simplifies dependency management by following the Dependency Inversion Principle. It allows for easy configuration and swapping of dependencies at runtime using Swift property wrappers and protocols.

## Key Features

- **Decoupled Dependencies**: Inject and manage dependencies without tightly coupling them to the classes that use them.
- **Testable**: Facilitates dependency injection for testing, allowing for easy mocking and swapping of services.
- **Swift Property Wrappers**: Use the `@Injectable` property wrapper to access dependencies directly within your classes.

## Installation

**Swift Package Manager (SPM)**: 
   - Add the repository URL to your project’s package dependencies.

## Usage

### Basic Structure

**DependencyInjector** is built using two main components:
1. `@Injectable`: A property wrapper that allows you to inject dependencies into your classes.
2. `InjectableValues`: A global structure that stores and retrieves dependencies.

### Creating Dependencies

To define a dependency, conform your class or structure to the `InjectableDependency` protocol:

```swift
protocol Logger {
    func logData(data: String)
    func logError(error: Error)
}

class DataLogger: Logger {
    func logData(data: String) {
        print(data)
    }
    
    func logError(error: Error) {
        print(error)
    }
}

struct DataLoggerDependency: InjectableDependency {
    static var dependency: Logger = DataLogger()
}
```

### Registering Dependencies

Use the  `InjectableValues`  structure to register dependencies globally. You can define default values for your dependencies and access them later using key paths.

```swift
extension InjectableValues {
    var dataLogger: Logger {
        DataLogger()
    }
    
    var mockLogger: Logger {
        get {
            Self[DataLoggerDependency.self]
        }
        set {
            Self[DataLoggerDependency.self] = newValue
        }
    }
}
```

### Injecting Dependencies

Use the  `@Injectable`  property wrapper to inject the dependency into any class or struct. The wrapper uses a key path to access the desired dependency.

```swift
class SomeClass {
    @Injectable(\.dataLogger) var logger: Logger
    
    func performAction() {
        logger.logData(data: "Some action performed")
    }
}
```

### Swapping Dependencies (For Testing or Custom Configurations)

You can swap out dependencies easily for different scenarios, such as testing with mocks:

```swift
class MockLogger: Logger {
    func logData(data: String) {
        print("Mock log: \(data)")
    }
    
    func logError(error: Error) {
        print("Mock error: \(error)")
    }
}

// Replace the DataLogger dependency with a MockLogger
InjectableValues[DataLoggerDependency.self] = MockLogger()
```

### Example Usage in Unit Tests

Here’s how  **DependencyInjector**  simplifies dependency management during testing. You can replace real dependencies with mocks or other test-specific implementations.

```swift
class DependencyInjectorTests: XCTestCase {
    
    @Injectable(\.dataLogger) var logger: Logger
    @Injectable(\.mockLogger) var mock: Logger
    
    func testExample() {
        // Use `logger` and `mock` in your test cases
        logger.logData(data: "Test log")
        mock.logError(error: NSError(domain: "Test", code: 1, userInfo: nil))
    }
}
```

### Customizing Dependencies

You can create more sophisticated dependency graphs by defining different versions of the same dependency and swapping them as needed.

## API Reference

### `@Injectable<T>`

This property wrapper allows for dependency injection in your classes or structs. It retrieves and injects dependencies based on the key path provided.

-   **`wrappedValue`**: The dependency being injected.
-   **Initializer**:  `Injectable(_ keyPath: KeyPath<InjectableValues, T>)`

### `InjectableValues`

This structure stores and retrieves dependencies using subscripts. Dependencies are stored globally and can be customized per application context.

-   **Subscript**: Access dependencies via key paths.

```swift
public static subscript<T>(keyPath: KeyPath<InjectableValues, T>) -> T
```

### `InjectableDependency`

This protocol defines the structure for dependencies that can be injected using  **DependencyInjector**.

-   **`associatedtype Dependency`**: The type of the dependency.
-   **Static Variable**:  `static var dependency: Dependency { get set }`
