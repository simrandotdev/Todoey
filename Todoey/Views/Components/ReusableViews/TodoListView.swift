//
//  TodoListView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var todoManager: TodoManager
    
    var body: some View {
        List {
            ForEach($todoManager.todos, content: { todo in
                NavigationLink {
                    UpdateTodoView(todo: todo.wrappedValue, todoManager: todoManager)
                } label: {
                    TodoItemRow(todo: todo)
                        .contextMenu {
                            Button(todo.isFavorite.wrappedValue ? "Remove from Favorites" :"Add to Favorites") {
                                todoManager.update(todo: todo.wrappedValue, isFavorites: !todo.isFavorite.wrappedValue)
                            }
                            
                            Button(todo.isDone.wrappedValue ? "Mark as Undone" : "Mark as Done") {
                                todoManager.update(todo: todo.wrappedValue, isDone: !todo.isDone.wrappedValue)
                            }
                        }
                }
            })
            .onDelete { indexSet in
                
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoManager: TodoManager())
    }
}
