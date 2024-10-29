import SwiftUI

struct ContentView: View {
    let todos = Todo.getTodos()
    @State private var vibrateOnRing = false

    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    addTodo(name: "Check")
                }, label: {
                    Text("+")
                })
                .padding(20)
                Button(action: {
                    readDb()
                }, label: {
                    Text("Read DB")
                })
            }
            List {
                Section("UnChecked") {
                    ForEach(todos) { todo in
                        HStack {
                            Text(todo.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            // Используем NavigationLink для перехода на экран деталей
                            NavigationLink(destination: TodoDetails(todo: todo)) {
                         EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .opacity(0)
                            
                            // Кнопка для изменения состояния
                            Button(action: {
                                vibrateOnRing.toggle()
                            }) {
                                Image(systemName: vibrateOnRing ? "checkmark.square" : "square")
                            }
                            .buttonStyle(PlainButtonStyle()) // Убираем стиль кнопки
                        }
                    }
                }
            }
            .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
