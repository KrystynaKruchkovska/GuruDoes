//
//  Task.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import CoreData

extension Task {
    // var priorityLevelValue:Int32
    var priorityLevel: TaskPriority {
        get {
            return TaskPriority(rawValue: self.priorityLevelValue)!
        }
        set {
            self.priorityLevelValue = newValue.rawValue
        }
    }
    
}
