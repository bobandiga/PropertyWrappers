//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

// Class for prevent accidental copying

import Foundation

@propertyWrapper
public struct AtomicL<Value> {
    
    private let lock: NSLocking
    
    public init(isRecursive: Bool = false, wrappedValue: Value) {
        self.value = wrappedValue
        self.lock = isRecursive ? NSRecursiveLock() : NSLock()
    }
    
    private var value: Value
    
    public var wrappedValue: Value {
        get {
            lock.lock()
            defer { lock.unlock() }
            return value
        }
        set {
            lock.lock()
            value = newValue
            lock.unlock()
        }
    }
    
}
