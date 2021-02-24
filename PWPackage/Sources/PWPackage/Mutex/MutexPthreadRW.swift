//
//  File.swift
//  
//
//  Created by Максим Шаптала on 24.02.2021.
//

import Foundation

public class MutexPthreadRW: RWMutex {
        
    public var mutex = pthread_rwlock_t()
    
    public init() {
        var attr = pthread_rwlockattr_t()
        
        guard pthread_rwlockattr_init(&attr) == 0 else {
            return
        }
        
        guard pthread_rwlock_init(&mutex, &attr) == 0 else {
            return
        }
        
        pthread_rwlockattr_destroy(&attr)
    }
    
    deinit {
        pthread_rwlock_destroy(&mutex)
    }
    
    public func tryRLock() -> Bool {
        return pthread_rwlock_tryrdlock(&mutex) == 0
    }
    
    public func tryWLock() -> Bool {
        return pthread_rwlock_trywrlock(&mutex) == 0
    }
    
    public func rLock() {
        pthread_rwlock_rdlock(&mutex)
    }
    
    public func wLock() {
        pthread_rwlock_wrlock(&mutex)
    }
    
    public func unlock() {
        pthread_rwlock_unlock(&mutex)
    }
    
}
