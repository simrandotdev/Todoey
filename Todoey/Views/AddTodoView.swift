//
//  AddTodoView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct AddTodoView: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var addToFavorites: Bool = false
    @Environment(\.dismiss) var dismiss
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
                
                FormButton(title: "Save") {
                    
                    todoManager.save(title: title, description: description, isFavorites: addToFavorites)
                    dismiss()
                }
                .foregroundColor(.green)
            }
            .navigationTitle("Add a new Todo")
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(todoManager: .init())
    }
}
