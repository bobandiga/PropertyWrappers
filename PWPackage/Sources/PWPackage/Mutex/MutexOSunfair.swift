//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

public class MutexOSunfair: Mutex {
    public var mutex: os_unfair_lock = os_unfair_lock()
    
    public init () {}
    
    public func lock() {
        os_unfair_lock_lock(&mutex)
    }
    
    public func tryLock() -> Bool {
        return os_unfair_lock_trylock(&mutex)
    }
    
    public func unlock() {
        os_unfair_lock_unlock(&mutex)
    }
    
}


