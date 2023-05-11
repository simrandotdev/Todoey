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
    @Environment(\.dismiss) var dismiss
    
    private var todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
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
                
                FormButton(title: "Update") {
                    
                    dismiss()
                }
                .foregroundColor(.green)
                
                FormButton(title: "Mark as done") {
                    
                    dismiss()
                }
                .foregroundColor(.accentColor)
            }
            .navigationTitle("Add a new Todo")
            .toolbar {
                RoundedSystemImageToolbarItem(placement: .bottomBar, systemImageName: "xmark.bin") {
                    
                }
            }
        }
        .onAppear {
            title = todo.title
            description = todo.description
            addToFavorites = todo.isFavorite
        }
    }
    
}

struct UpdateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTodoView(todo: .init(title: "Wash Clothes", description: "Wash all the clothes today and fold them"))
    }
}
