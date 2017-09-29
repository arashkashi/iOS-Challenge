//
//  Utils.swift
//  CoreStore
//
//  Created by Arash Kashi on 12/13/16.
//  Copyright © 2016 Arash K. All rights reserved.
//

import Foundation
import CoreData



func isRunningTests() -> Bool {
  
  return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}


extension NSLock {
  
  func withCriticalScope<T>(_ block: () -> T) -> T {
    lock()
    let value = block()
    unlock()
    return value
  }
}

