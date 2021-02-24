//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

@propertyWrapper
public struct AtomicGCD<Value> {
    
    private let queue: DispatchQueue
    
    public init(qos: DispatchQoS = .default, wrappedValue: Value) {
        self.queue = DispatchQueue(label: "GCDMutext \(UUID().uuidString)", qos: qos, attributes: .concurrent)
        self.value = wrappedValue
    }
    
    private var value: Value
    
    public var wrappedValue: Value {
        get {
            return queue.sync {
                return value
            }
        }
        set {
            queue.sync {
                value = newValue
            }
        }
    }
    
}
