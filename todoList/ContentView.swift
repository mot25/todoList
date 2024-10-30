import SwiftUI

struct ContentView: View {
//    let todos = Todo.getTodos()
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
//                Button(action: {
//                    readTodos()
//                }, label: {
//                    Text("Read Db")
//                })
//                .padding(20)
               
            }
			List(todoModel.todos, id: \.self) {todo in
Text(todo)
			}
//            List {
//                Section("UnChecked") {
//                    ForEach(todos) { todo in
//                        HStack {
//                            Text(todo.name)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            // Используем NavigationLink для перехода на экран деталей
//                            NavigationLink(destination: TodoDetails(todo: todo)) {
//                         EmptyView()
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                            .opacity(0)
//                            
//                            // Кнопка для изменения состояния
//                            Button(action: {
//                                vibrateOnRing.toggle()
//                            }) {
//                                Image(systemName: vibrateOnRing ? "checkmark.square" : "square")
//                            }
//                            .buttonStyle(PlainButtonStyle()) // Убираем стиль кнопки
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
