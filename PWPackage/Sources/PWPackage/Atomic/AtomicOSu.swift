//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

@propertyWrapper
public struct AtomicOSu<Value> {
    
    private let mutex: BaseMutex
    
    public init(isRecursive: Bool = false, wrappedValue: Value) {
        self.value = wrappedValue
        self.mutex = MutexOSunfair()
    }
    
    private var value: Value
    
    public var wrappedValue: Value {
        get {
            return mutex.sync {
                return value
            }
        }
        set {
            mutex.trySync {
                value = newValue
            }
        }
    }
    
}
