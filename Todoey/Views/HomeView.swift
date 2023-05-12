//
//  ContentView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var todoManager = TodoManager()
    @State private var showAddTodoView: Bool = false
    @State private var showSortByConfirmDialog: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if todoManager.todos.isEmpty {
                    EmptyStateView(systemImageName: "note",
                                   message: "Your list is empty. \nPlease create some todos")
                } else {
                    TodoListView(todoManager: todoManager)
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
                AddTodoView(todoManager: todoManager)
            }
            .confirmationDialog("Sort By", isPresented: $showSortByConfirmDialog) {
                Button("Done") {
                    todoManager.sortBy(.done)
                }
                
                Button("Favorites") {
                    todoManager.sortBy(.favorites)
                }
                
                Button("Created By") {
                    todoManager.sortBy(.creation)
                }
                
                Button("Updated By") {
                    todoManager.sortBy(.updation)
                }
            }
        }
        .onAppear {
            todoManager.fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
