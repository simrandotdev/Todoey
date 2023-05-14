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
    @State private var doneButtonTitle: String = ""
    @State private var isDone: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var todo: Todo
    @ObservedObject var todoManager: TodoManager
    
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
                
                FormButton(title: doneButtonTitle) {
                    isDone = !isDone
                }
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
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
            }
        }
        .onAppear {
            title = todo.title
            description = todo.description
            addToFavorites = todo.isFavorite
            isDone = todo.isDone
            doneButtonTitle = isDone ? "Mark Undone" : "Mark Done"
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    todoManager.update(todo: todo, withTitle: title, description: description, isDone: isDone, isFavorite: addToFavorites)
                    dismiss()
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
            }
        }
        .onChange(of: isDone) { isDone in
            doneButtonTitle = isDone ? "Mark Undone" : "Mark Done"
        }
    }
    
}

struct UpdateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTodoView(todo: .constant(.init(title: "Wash Clothes", description: "Wash all the clothes today and fold them")), todoManager: .init())
    }
}
