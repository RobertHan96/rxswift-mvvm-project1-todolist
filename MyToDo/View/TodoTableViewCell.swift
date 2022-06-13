import UIKit
import RxSwift

class TodoTableViewCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"
    private let cellDisposeBag = DisposeBag()
    let onData: AnyObserver<TodoRealmModel>
    var disposeBag = DisposeBag()
    @IBOutlet weak var todoLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        let data = PublishSubject<TodoRealmModel>()
        onData = data.asObserver()

        super.init(coder: aDecoder)

        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] todo in
                self?.todoLabel.text = todo.todo
                
            })
            .disposed(by: cellDisposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

}
