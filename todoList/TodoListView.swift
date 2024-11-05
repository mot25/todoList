//
//  TodoListView.swift
//  todoList
//
//  Created by Матвей Погодаев on 06.11.2024.
//

import SwiftUI

struct TodoListView: View {
	@State private var vibrateOnRing = false
	@State private var textNewTodo: String = ""
	@StateObject private var todoModel = TodoModel()
	var body: some View {
		NavigationStack {
			HStack {
				TextField("New Task", text: $textNewTodo)
					.textFieldStyle(RoundedBorderTextFieldStyle())


				Button(action: {
					todoModel.addTodo(name1: textNewTodo)
					textNewTodo = ""
				}, label: {
					Text("+")
				})
				.padding(20)

			}
			List(todoModel.todos, id: \.id) {todo in
				HStack {
					Text(todo.name)
						.frame(maxWidth: .infinity, alignment: .leading)


					NavigationLink(destination: TodoDetails(todo: todo)) {
				 EmptyView()
					}
					.buttonStyle(PlainButtonStyle())
					.opacity(0)

								Button(action: {
									todoModel.toggleIsCheck(id1: todo.id)
					}) {
						Image(systemName: todo.isCheck == 1 ? "checkmark.square" : "square")
					}
					.buttonStyle(PlainButtonStyle())
					Button(action: {
						todoModel.deleteTodo(id1: todo.id)
					}) {
						Image(systemName: "trash")
					}
					.buttonStyle(PlainButtonStyle())
					.padding()
				}
			}
		}
	}
}

#Preview {
    TodoListView()
}
