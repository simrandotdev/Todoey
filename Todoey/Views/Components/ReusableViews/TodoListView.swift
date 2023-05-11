//
//  TodoListView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct TodoListView: View {
    
    @Binding var todos: [Todo]
    
    var body: some View {
        List {
            ForEach($todos, content: { todo in
                NavigationLink {
                    UpdateTodoView(todo: todo.wrappedValue)
                } label: {
                    TodoItemRow(todo: todo)
                        .contextMenu {
                            Button("Add to Favorites") {
                                
                            }
                            
                            Button("Mark as Done") {
                                
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
        TodoListView(todos: .constant([]))
    }
}
