//
//  GroceryListView.swift
//  task-management-swiftdata
//
//  Created by FELIPE AUGUSTO SILVA on 17/02/24.
//

import SwiftUI
import SwiftData

struct GroceryListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Tasks]
    @State private var selection = 0
    
    var body: some View {
        NavigationSplitView {
            // Picker
            Picker(selection: $selection, label: Text("Select an option")) {
                Text("Todo").tag(0)
                Text("Done").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // Content based on selection and items availability
            if items.isEmpty {
                emptyState
            } else {
                nonEmptyState
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    // MARK: - Views
    
    // Empty state view
    private var emptyState: some View {
        VStack {
            ContentUnavailableView {
                Label("No items found", systemImage: "doc.richtext.fill")
            } description: {
                Text("Try to add new items.")
            }
            
            Button("Add") {
                addItem()
            }
        }
    }
    
    // Non-empty state view
    private var nonEmptyState: some View {
        VStack {
            GroceryList(showDoneItems: selection == 1) { index in
                deleteItems(offsets: index)
            } addItem: {
                addItem()
            }
            
            Button("Clear") {
                clearItems()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    // Add new item
    private func addItem() {
        withAnimation(.spring) {
            let newItem = Tasks(taskID: UUID(), taskName: "", done: false)
            modelContext.insert(newItem)
        }
    }
    
    // Delete selected items
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach { item in
                modelContext.delete(item)
            }
        }
    }
    
    // Clear all items
    private func clearItems() {
        withAnimation {
            items.forEach { modelContext.delete($0) }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
            .modelContainer(for: Tasks.self, inMemory: true)
    }
}
