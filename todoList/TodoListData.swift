import Foundation
import SQLite
import Combine

struct TodoModelInterface {
	var id: Int64
	var name: String
	var isCheck: Int64
}


class TodoModel: ObservableObject {
	@Published var todos: [TodoModelInterface] = []

	private var db: Connection?

	init() {
		do {
			let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
			_ = copyDatabaseIfNeeded(sourcePath: Bundle.main.path(forResource: "todo", ofType: "db")!)
			db = try Connection("\(path)/todo.db")
			fetchTodos()
		} catch {
			print("Ошибка подключения к базе данных:", error)
		}
	}

	func deleteTodo(id1: Int64) {
		print("delete")
		do {
			guard let db = db else { return }
			let tableTodos = Table("todos")
			let id = Expression<Int64>("id")
			let deleteCandidate = tableTodos.filter(id === id1)
			try db.run(deleteCandidate.delete())
			fetchTodos()
		}catch {
			print("delete todo", error)
		}
	}


	func toggleIsCheck(id1: Int64){
		do {
			guard let db = db else { return }
			let tableTodos = Table("todos")
			let id = Expression<Int64>("id")
			let isCheck = Expression<Int64?>("isCheck")
			let alice = tableTodos.filter(id == id1)
			
			for todo in try db.prepare(alice) {
				let prevIsCheck = try todo.get(isCheck)
				let newValue: Int64 = (prevIsCheck == nil || prevIsCheck == 0) ? 1 : 0
				try db.run(alice.update(isCheck <- newValue))
			}
			fetchTodos()
		} catch {
			print("edit isCheck", error)
		}
	}

	func fetchTodos() {
		do {
			guard let db = db else { return }
			let tableTodos = Table("todos")
			var todosList = [TodoModelInterface]()
			let id = Expression<Int64>("id")
			let name = Expression<String>("name")
			let isCheck = Expression<Int64?>("isCheck")
			for todo in try db.prepare(tableTodos) {
				let candidateTodo = TodoModelInterface(
					id: try todo.get(id), name: try todo.get(name), isCheck: try todo.get(isCheck) ?? 0
				)
				todosList.append(candidateTodo)
			}
			todos = todosList
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
