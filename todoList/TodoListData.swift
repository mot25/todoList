import Foundation
import SQLite

func addTodo(name: String) {
    do {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        // Подключение к базе данных
        let db = try Connection("\(path)/Todo.db")
        print(db)
        // Определение таблицы и столбцов
        let todos = Table("todos")
        let id = Expression<Int64>("id")
        let todoName = Expression<String>("name")

        // Создание таблицы, если она не существует
        try db.run(todos.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(todoName)
        })
        
        // Вставка нового Todo, если имя не пустое
        if !name.isEmpty {
            let insert = todos.insert(todoName <- name)
            try db.run(insert)
            print("Todo добавлен: \(name)")
        }
    } catch {
        print("Ошибка при добавлении Todo:", error)
    }
}

func readDb () {
    do {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        let db = try Connection("\(path)/Todo.db")
        let todos = Table("todos")
        for todo in try db.prepare(todos) {
            print(todo)
        }
    } catch {
        print(error)
    }
}


func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
    let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let destinationPath = documents + "/Todo.db"
    let exists = FileManager.default.fileExists(atPath: destinationPath)
    guard !exists else { return false }
    do {
        try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
        return true
    } catch {
        print("Ошибка при копировании файла: \(error)")
        return false
    }
}
