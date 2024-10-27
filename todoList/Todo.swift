//
//  TodoModel.swift
//  todo list
//
//  Created by Матвей Погодаев on 26.10.2024.
//

import Foundation

struct Todo: Identifiable, Hashable {
    var id = UUID()
    
    let isCheck: Bool?
    let name: String
    
    init(name: String, isCheck: Bool? = nil) {
        self.name = name
        self.isCheck = isCheck
    }
    
    static func getTodos() -> [Todo] {
        [
            Todo(name: "todo 1", isCheck: false),
            Todo(name: "todo 2",isCheck: true),
            Todo(name: "todo 3", isCheck: true),
            Todo(name: "todo 4"),
        ]
    }
}
