import UIKit
import RealmSwift

@objcMembers class TodoRealmModel: Object {
    @objc dynamic var todo : String = ""
    @objc dynamic var date : String = ""
    @objc dynamic var isDone : Bool = false
}

class TodoModel {
    var todoArrary: Results<TodoRealmModel>?
    
    init(todo: String) {
        let todoRealmModel = TodoRealmModel()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: date)
        todoRealmModel.date = currentDate
        todoRealmModel.todo = todo
        commitRealDatabase(model: todoRealmModel)
        
    }
    
    private func commitRealDatabase(model: TodoRealmModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(model)
        }
    }
}
