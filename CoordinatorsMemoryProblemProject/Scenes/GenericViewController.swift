//
//  SceneOneViewController.swift
//  CoordinatorsMemoryProblemProject
//

import UIKit
import RxSwift
import RxCocoa

class GenericViewController: BaseViewController<GenericViewModel, GenericView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        _view.buttonTitle = viewModel.buttonTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func bindUI() {
        _view.didTapOnNextButton.bind(to: viewModel.didTapOnNextButton).disposed(by: disposeBag)
    }
}
