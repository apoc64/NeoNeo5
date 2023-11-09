//
//  Container.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

/*
 Container is a lightweight dependency injection system adapted from
 ktatroe/MPA-Horatio available at https://github.com/ktatroe/MPA-Horatio
 
 Register a new Container registry:
 Container.register(MyType.self) { _ in MyType() }
 
 Retreive the instance your registered:
 Container.register(MyType.self)
 */

import Foundation

/**
 Stores instances of a given type for later retreival
 */
open class Container {
    static internal var shared = Container()

    fileprivate var services = [ContainerItemKey: ContainerItemType]()

    // Prevent multiple threads from trying to do the same thing at the same time
    fileprivate let servicesLock = NSRecursiveLock()

    open func register<T>(_ serviceType: T.Type, name: String? = nil, factory: @escaping (Resolvable) -> T) -> ContainerEntry<T> {
        registerFactory(serviceType, factory: factory, name: name)
    }

    internal func registerFactory<T, Factory>(_ serviceType: T.Type, factory: Factory, name: String?) -> ContainerEntry<T> {
        let key = ContainerItemKey(factoryType: type(of: factory), name: name)
        let entry = ContainerEntry(serviceType: serviceType, factory: factory)

        servicesLock.lock()

        defer {
            servicesLock.unlock()
        }

        services[key] = entry

        return entry
    }

    /**
     Store an instance of a type in Container
     - parameter serviceType: The type you wish to store - MyType.self
     - parameter name: Optional string key for storing multiple instances of same type
     - parameter factory: Block that returns an instance of your type - { _ in MyType() }
     */
    @discardableResult
    static public func register<T>(_ serviceType: T.Type, name: String? = nil, factory: @escaping (Resolvable) -> T) -> ContainerEntry<T> {
        shared.register(serviceType, name: name, factory: factory)
    }
}


extension Container : Resolvable {
    
    public func resolve<T>(_ serviceType: T.Type, name: String? = nil) -> T? {
        typealias FactoryType = (Resolvable) -> T

        return resolveFactory(name) { (factory: FactoryType) in factory(self) }
    }

    /**
     Retrieve stored instance of a type from Container
     - parameter serviceType: The type you wish to retreive - MyType.self
     - parameter name: Optional string key for storing multiple instances of same type
     */
    static public func resolve<T>(_ serviceType: T.Type, name: String? = nil) -> T? {
        shared.resolve(serviceType, name: name)
    }

    internal func resolveFactory<T, Factory>(_ name: String?, invoker: (Factory) -> T) -> T? {
        let key = ContainerItemKey(factoryType: Factory.self, name: name)

        servicesLock.lock()

        defer {
            servicesLock.unlock()
        }

        guard let entry = services[key] as? ContainerEntry<T> else { return fail(reason: .entry, key: key) }
        
        if entry.instance == nil {
            entry.instance = resolveEntry(entry, key: key, invoker: invoker) as Any
        }
        
        guard let instance = entry.instance as? T else { return fail(reason: .instance, key: key) }
        
        return instance
    }
    
    fileprivate func fail<T>(reason: ContainerFailureReason, key: ContainerItemKey) -> T? {
        return nil
    }

    fileprivate func resolveEntry<T, Factory>(_ entry: ContainerEntry<T>, key: ContainerItemKey, invoker: (Factory) -> T) -> T {
        let resolvedInstance = invoker(entry.factory as! Factory)

        return resolvedInstance
    }
}

enum ContainerFailureReason {
    case entry
    case instance
    
    var failureDescription: String {
        switch self {
        case .entry:
            return "find Container entry"
        case .instance:
            return "generate Container instance"
        }
    }
}


public typealias FunctionType = Any

public enum ResolvableError: Error {
    case invalidType
    case entryMissing(forKey: String)
}

public protocol Resolvable {
    func resolve<T>(_ serviceType: T.Type, name: String?) -> T?
}


internal struct ContainerItemKey {
    fileprivate let factoryType: FunctionType.Type
    fileprivate let name: String?

    internal init(factoryType: FunctionType.Type, name: String? = nil) {
        self.factoryType = factoryType
        self.name = name
    }
}

extension ContainerItemKey: CustomStringConvertible {
    var description: String {
        return "type: \(factoryType) name: \(name ?? "nil")"
    }
}


extension ContainerItemKey : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: factoryType).hashValue ^ (name?.hashValue ?? 0))
    }
}

func == (lhs: ContainerItemKey, rhs: ContainerItemKey) -> Bool {
    return (lhs.factoryType == rhs.factoryType) && (lhs.name == rhs.name)
}


internal typealias ContainerItemType = Any

open class ContainerEntry<T> : ContainerItemType {
    fileprivate let serviceType: T.Type
    let factory: FunctionType

    var instance: Any? = nil

    init(serviceType: T.Type, factory: FunctionType) {
        self.serviceType = serviceType
        self.factory = factory
    }
}
