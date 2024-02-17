//
//  task_management_swiftdataApp.swift
//  task-management-swiftdata
//
//  Created by FELIPE AUGUSTO SILVA on 17/02/24.
//

import SwiftUI
import SwiftData

@main
struct task_management_swiftdataApp: App {

    var body: some Scene {
        WindowGroup {
            GroceryListView()
        }
        .modelContainer(Containers.sharedGroceriesContainer)
    }
}
