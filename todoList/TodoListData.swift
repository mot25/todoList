import Foundation
import SQLite
import Combine

class TodoModel: ObservableObject {
	@Published var todos: [String] = []  // Массив, который будет содержать названия всех дел

	private var db: Connection?

	init() {
		do {
			// Установка пути к базе данных
			let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
			_ = copyDatabaseIfNeeded(sourcePath: Bundle.main.path(forResource: "todo", ofType: "db")!)
			db = try Connection("\(path)/todo.db")
			fetchTodos()  // Загрузка начальных данных
		} catch {
			print("Ошибка подключения к базе данных:", error)
		}
	}

	func fetchTodos() {
		do {
			guard let db = db else { return }
			let tableTodos = Table("todos")
			let name = Expression<String>("name")
			var todosList = [String]()
			for todo in try db.prepare(tableTodos) {
				todosList.append(try todo.get(name))
			}
			todos = todosList  // Обновление @Published свойства, чтобы ContentView получил обновления
		} catch {
			print("Ошибка при чтении базы данных:", error)
		}
	}

	func addTodo(name1: String) {
		do {
			guard let db = db else { return }
			let todosTable = Table("todos")
			let todoName = Expression<String>("name")
			try db.run(todosTable.insert(todoName <- name1))
			fetchTodos()  
		} catch {
			print("Ошибка при добавлении Todo:", error)
		}
	}

	private func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
		let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let destinationPath = documents + "/todo.db"
		let exists = FileManager.default.fileExists(atPath: destinationPath)
		guard !exists else { return false }
		do {
			try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
			return true
		} catch {
			print("Ошибка при копировании файла базы данных:", error)
			return false
		}
	}
}
