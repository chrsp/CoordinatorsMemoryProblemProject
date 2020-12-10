//
//  BaseViewController.swift
//  ios-swift-template
//

import UIKit
import RxSwift

open class BaseViewController<ViewModel: ViewModelType, View: BaseView>: UIViewController {
    public let _view: View!
    public let viewModel: ViewModel
    public let disposeBag = DisposeBag()

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self._view = View()
        super.init(nibName: nil, bundle: nil)
        bindUI()
    }

    open override func loadView() {
        super.loadView()
        _view.frame = view.frame
        self.view = _view
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // Used to bind all reactive behavior to your ViewController
    open func bindUI() {
        
    }
}
