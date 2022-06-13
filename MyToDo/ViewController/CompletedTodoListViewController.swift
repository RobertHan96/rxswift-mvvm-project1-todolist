import UIKit
import RxCocoa
import RxSwift

class CompletedTodoListViewController: UIViewController{
    let viewModel: CompletedListViewModelType
    let disposeBag = DisposeBag()
    @IBOutlet weak var completedTodoListTableView: UITableView!
    
    init(viewModel: CompletedListViewModelType = CompletedListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = CompletedListViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        Observable.from( [viewModel.completedTodo] )
            .bind(to :completedTodoListTableView.rx.items(cellIdentifier: CompletedTodoTableViewCell.identifier,
                                                          cellType: CompletedTodoTableViewCell.self)) {
                tableView, item, cell in
                cell.onData.onNext(item)
          }
          .disposed(by: disposeBag)
    }
}
