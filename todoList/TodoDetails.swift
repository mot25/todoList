//
//  TodoDetails.swift
//  todoList
//
//  Created by Матвей Погодаев on 27.10.2024.
//

import SwiftUI

struct TodoDetails: View {
    let todo: TodoModelInterface

    var body: some View {
        Text(todo.name)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .navigationTitle(todo.name)
    }
}

#Preview {
    TodoDetails(todo: TodoModelInterface(id: 1, name: "nameTodo", isCheck: 1))
}
