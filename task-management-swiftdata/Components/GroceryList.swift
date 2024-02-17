//
//  GroceryList.swift
//  task-management-swiftdata
//
//  Created by FELIPE AUGUSTO SILVA on 17/02/24.
//

import SwiftUI
import SwiftData

struct GroceryList: View {
    @Query private var items: [Tasks]
    var showDoneItems: Bool = false
    var deleteItem: (_ index: IndexSet) -> Void
    var addItem: () -> Void
    
    var body: some View {
        List {
            Section("Grocery List") {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    if (showDoneItems && item.done) || (!showDoneItems && !item.done) {
                        itemCard(item: item)
                    }
                }
                .onDelete(perform: deleteItem)
            }
        }
        .listStyle(.plain)
        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    @ViewBuilder private func itemCard(item: Tasks) -> some View {
        HStack {
            Toggle(isOn: binding(for: item), label: {
                TextField("Example ...", text: binding(for: item.taskName))
                    .frame(minWidth: 100, minHeight: 50)
                    .disabled(item.done)
            })
        }
    }
    
    private func binding(for text: String) -> Binding<String> {
        Binding(
            get: {
                if let index = self.items.firstIndex(where: { $0.taskName == text }) {
                    return self.items[index].taskName
                }
                return ""
            },
            set: { newValue in
                if let index = self.items.firstIndex(where: { $0.taskName == text }) {
                    self.items[index].taskName = newValue
                }
            }
        )
    }
    
    private func binding(for item: Tasks) -> Binding<Bool> {
        Binding(
            get: {
                item.done
            },
            set: { newValue in
                if let index = self.items.firstIndex(where: { $0.id == item.id }) {
                    withAnimation {
                        self.items[index].done = newValue
                    }
                }
            }
        )
    }
}
