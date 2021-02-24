//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

@propertyWrapper
public struct AtomicPthRW<Value> {
    
    private var mutex: RWBaseMutex
    
    public init(isRecursive: Bool = false, wrappedValue: Value) {
        self.value = wrappedValue
        self.mutex = MutexPthreadRW()
    }
    
    private var value: Value
    
    public var wrappedValue: Value {
        get {
            return mutex.syncR {
                return value
            }
        }
        set {
            mutex.syncW {
                value = newValue
            }
        }
    }
}
