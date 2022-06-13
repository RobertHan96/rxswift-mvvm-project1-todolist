//
//  DoneListViewModel.swift
//  MyToDo
//
//  Created by HanaHan on 2022/05/30.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol CompletedListViewModelType {
    var completedTodo: Results<TodoRealmModel> { get }
}

protocol CompletedTodoFetchable {
    func fetchCompletedTodoList() -> Results<TodoRealmModel>
}

class CompletedTodoStore: CompletedTodoFetchable {
    let realm = try! Realm()
    let disposeBag = DisposeBag()

    func fetchCompletedTodoList() -> Results<TodoRealmModel> {
        return realm.objects(TodoRealmModel.self).filter("isDone = 1").sorted(byKeyPath: "date", ascending: true)
    }
}

class CompletedListViewModel: CompletedListViewModelType {
    var completedTodo: Results<TodoRealmModel>
    
    init(domain: CompletedTodoFetchable = CompletedTodoStore()) {
        completedTodo = CompletedTodoStore().fetchCompletedTodoList()
    }
}
