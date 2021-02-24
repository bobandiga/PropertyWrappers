//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

public protocol BaseMutex {
    func sync<T>(_ execute: () throws -> T) rethrows -> T
    func trySync<T>(_ execute: () throws -> T) rethrows -> T?
}

public protocol Mutex: BaseMutex {
    associatedtype Primitive
    var mutex: Primitive { get }
    
    func lock()
    func unlock()
    func tryLock() -> Bool
}

public extension Mutex {
    func sync<T>(_ execute: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try execute()
    }
    
    func trySync<T>(_ execute: () throws -> T) rethrows -> T? {
        guard tryLock() else { return nil }
        defer { unlock() }
        return try execute()
    }
}

public protocol RWBaseMutex {
    func syncW<T>(_ execute: () throws -> T) rethrows -> T
    func trySyncW<T>(_ execute: () throws -> T) rethrows -> T?
    
    func syncR<T>(_ execute: () throws -> T) rethrows -> T
    func trySyncR<T>(_ execute: () throws -> T) rethrows -> T?
}

public protocol RWMutex: RWBaseMutex {
    associatedtype Primitive
    var mutex: Primitive { get }
    
    func tryRLock() -> Bool
    func tryWLock() -> Bool
    func rLock()
    func wLock()
    func unlock()
}

public extension RWMutex {
    public func syncW<T>(_ execute: () throws -> T) rethrows -> T {
        wLock()
        defer { unlock() }
        return execute()
    }
    
    public func trySyncW<T>(_ execute: () throws -> T) rethrows -> T? {
        guard tryWLock() else { return nil }
        defer { unlock() }
        return execute()
    }
    
    public func syncR<T>(_ execute: () throws -> T) rethrows -> T {
        rLock()
        defer { unlock() }
        return execute()
    }
    
    public func trySyncR<T>(_ execute: () throws -> T) rethrows -> T? {
        guard tryRLock() else { return nil }
        defer { unlock() }
        return execute()
    }
}
