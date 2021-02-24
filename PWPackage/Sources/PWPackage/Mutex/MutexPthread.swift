//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

public class MutexPthread: Mutex {
    
    public var mutex: pthread_mutex_t = pthread_mutex_t()
    
    public init(isRecursive: Bool) {
        var attr = pthread_mutexattr_t()
        guard pthread_mutexattr_init(&attr) == 0 else {
            return
        }
        
        isRecursive
            ? pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
            : pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL)
        
        guard pthread_mutex_init(&mutex, &attr) == 0 else {
            return
        }
        
        pthread_mutexattr_destroy(&attr)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    public func tryLock() -> Bool {
        return pthread_mutex_trylock(&mutex) == 0
    }
    
    public func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    public func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}
