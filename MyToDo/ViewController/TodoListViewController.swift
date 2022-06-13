import UIKit
import RxCocoa
import RxSwift
import Toast_Swift

class TodoListViewController: UIViewController, UITextFieldDelegate{
    let viewModel: TodoListViewModelType
    let disposeBag = DisposeBag()
    @IBOutlet weak var todoInputField: UITextField!
    @IBOutlet weak var btnAddTodo: UIButton!
    @IBOutlet weak var todoListTableView: UITableView!

    @IBAction func btnMoveDoneList(_ sender: Any) {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    init(viewModel: TodoListViewModelType = TodoListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = TodoListViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        Observable.changeset(from: viewModel.todoList)
            .subscribe { [weak self] repos, changes in
                guard let tableView = self?.todoListTableView else { return }
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            .disposed(by: disposeBag)
        
        
        Observable.from( [viewModel.todoList] )
            .bind(to :todoListTableView.rx.items(cellIdentifier: TodoTableViewCell.identifier,
                                                          cellType: TodoTableViewCell.self)) {
                tableView, item, cell in
                cell.onData.onNext(item)
          }
          .disposed(by: disposeBag)
        
        btnAddTodo.rx.tap
            .bind{
                if self.todoInputField.text?.count ?? 0 >= 1 {
                    self.viewModel.addTodo(todoItem: self.todoInputField.text!)
                    return
                }
                self.view.makeToast("할 일을 작성해주세요", duration: 2.0, position : .center)
            }
            .disposed(by: disposeBag)
    }
}


