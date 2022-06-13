//
//  TodoListViewModel.swift
//  MyToDo
//
//  Created by HanaHan on 2022/05/30.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

protocol TodoListViewModelType {
    var todoList:  Results<TodoRealmModel> { get }
    func addTodo(todoItem: String)
}

protocol TodoFetchable {
    func fetchTodoList() -> Results<TodoRealmModel>

}

class TodoStore: TodoFetchable {
    let realm = try! Realm()
    let disposeBag = DisposeBag()

    func fetchTodoList() -> Results<TodoRealmModel> {
        let todoItems = realm.objects(TodoRealmModel.self).filter("done = 0").sorted(byKeyPath: "date", ascending: true)
        
        return todoItems
    }
    
}

class TodoListViewModel: TodoListViewModelType {
    var todoList: Results<TodoRealmModel>
    
    init(domain: TodoFetchable = TodoStore()) {
        todoList = TodoStore().fetchTodoList()
    }
    
    func addTodo(todoItem: String) {
        let todo = TodoModel(todo: todoItem)
    }

}
