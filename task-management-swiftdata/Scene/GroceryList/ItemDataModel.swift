//
//  ItemDataModel.swift
//  task-management-swiftdata
//
//  Created by FELIPE AUGUSTO SILVA on 17/02/24.
//

import Foundation
import SwiftData

@Model 
final class Tasks {
    var taskID: UUID
    var taskName: String
    var done: Bool
    
    init(taskID: UUID, taskName: String, done: Bool) {
        self.taskID = taskID
        self.taskName = taskName
        self.done = done
    }
}
