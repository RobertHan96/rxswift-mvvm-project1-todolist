//
//  RealmService.swift
//  MyToDo
//
//  Created by HanaHan on 2022/05/30.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    let vieModel: TodoListViewModel
    let realm = try! Realm()

    init(viewModel: TodoListViewModel) {
        self.vieModel = viewModel
    }
    
    func deleteTodo(dbIndex: Int) {
        let deletedTodo = vieModel.todoList[dbIndex]
        try! self.realm.write {
            self.realm.delete(deletedTodo)
        }
    }
    
    func completeTodo(dbIndex: Int) {
        let completedTodo = vieModel.todoList[dbIndex]
        try! self.realm.write {
            completedTodo.isDone = true
        }
    }
}
