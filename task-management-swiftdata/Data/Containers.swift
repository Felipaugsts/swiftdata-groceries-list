//
//  Containers.swift
//  task-management-swiftdata
//
//  Created by FELIPE AUGUSTO SILVA on 17/02/24.
//

import Foundation
import SwiftData

final class Containers {
    
    static var sharedGroceriesContainer: ModelContainer = {
        let schema = Schema([
            Tasks.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
