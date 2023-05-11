//
//  ContentView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct HomeView: View {
    
    @State private var todos: [Todo] = [
        .init(title: "Wash Clothes", description: "Wash all the underwears first"),
        
        .init(title: "Study", description: "Study SwiftUI Today", isDone: true, isFavorite: true)
    ]
    @State private var showAddTodoView: Bool = false
    @State private var showSortByConfirmDialog: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if todos.isEmpty {
                    EmptyStateView(systemImageName: "note",
                                   message: "Your list is empty. \nPlease create some todos")
                } else {
                    TodoListView(todos: $todos)
                }
            }
            .navigationTitle("Todoey")
            .toolbar {
                RoundedSystemImageToolbarItem(placement: .bottomBar, systemImageName: "plus") {
                    showAddTodoView = true
                }
                
                SystemImageToolbarItem(placement: .primaryAction,
                                       systemImage: "line.3.horizontal.decrease.circle") {
                    showSortByConfirmDialog = true
                }
            }
            .sheet(isPresented: $showAddTodoView) {
                AddTodoView()
            }
            .confirmationDialog("Sort By", isPresented: $showSortByConfirmDialog) {
                Button("Done") {
                    
                }
                
                Button("Favorites") {
                    
                }
                
                Button("Created By") {
                    
                }
                
                Button("Updated By") {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
