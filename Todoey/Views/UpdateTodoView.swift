//
//  UpdateTodoView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct UpdateTodoView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var addToFavorites: Bool = false
    @State private var showConfirmDeleteDialog: Bool = false
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var todoManager: TodoManager
    
    private var todo: Todo
    
    init(todo: Todo, todoManager: TodoManager) {
        self.todo = todo
        self.todoManager = todoManager
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("", text: $title)
                }
                
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(height: 164)
                }
                
                Toggle("Add to Favorites", isOn: $addToFavorites)
            }
            .navigationTitle("Add a new Todo")
            .toolbar {
                RoundedSystemImageToolbarItem(placement: .bottomBar, systemImageName: "xmark.bin") {
                    showConfirmDeleteDialog = true
                }
            }
            .confirmationDialog("Are you sure you want to delete this", isPresented: $showConfirmDeleteDialog) {
                Button("No") {
                    dismiss()
                }
                
                Button("Yes") {
                    todoManager.delete(todo)
                    dismiss()
                }
            }
        }
        .onAppear {
            title = todo.title
            description = todo.description
            addToFavorites = todo.isFavorite
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    todoManager.update(todo: todo, withTitle: title, description: description, isDone: todo.isDone, isFavorites: addToFavorites)
                    dismiss()
                }
            }
        }
    }
    
}

struct UpdateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTodoView(todo: .init(title: "Wash Clothes", description: "Wash all the clothes today and fold them"), todoManager: .init())
    }
}
