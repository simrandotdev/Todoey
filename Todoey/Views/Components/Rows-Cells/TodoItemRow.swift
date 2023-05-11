//
//  TodoItemRow.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct TodoItemRow: View {
    
    @Binding var todo: Todo
    
    var body: some View {
        HStack {
            Image(systemName: todo.isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .fontWeight(todo.isFavorite ? .heavy : .light)
            
            Text(todo.title)
                .fontWeight(.bold)
                .font(.body)
            
            Spacer()
            
            Image(systemName: todo.isDone ? "checkmark.circle.fill": "circle")
                .foregroundColor(.accentColor)
        }
    }
}

struct TodoItemRow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let todos: [Todo] = [
            .init(title: "Wash Clothes", description: "Wash all the underwears first"),
            
            .init(title: "Study", description: "Study SwiftUI Today")
        ]
        
        return NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoItemRow(todo: .constant(todo))
                }
            }
            .navigationTitle("Todoey")
        }
    }
}
