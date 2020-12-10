//
//  GenericView.swift
//  CoordinatorsMemoryProblemProject
//
//  Created by Charles Prado on 10/12/2020.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GenericView: BaseView {
    
    // MARK: - Public Properties
    
    let didTapOnNextButton = PublishSubject<Void>()
    
    var buttonTitle: String = "NEXT" {
        didSet {
            goToNextSceneButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    // MARK: - Private Properties
    
    private let goToNextSceneButton = UIButton(type: .system)
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func setupSubviews() {
        super.setupSubviews()
    }

    override func addSubviews() {
        super.addSubviews()
        
        addSubview(goToNextSceneButton)
    }

    override func setupAutoLayout() {
        super.setupAutoLayout()
        
        goToNextSceneButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(48)
        }
    }

    override func setupColorsAndStyles() {
        super.setupColorsAndStyles()
        
        backgroundColor = .white
    }
    
    override func bindUI() {
        super.bindUI()
        
        goToNextSceneButton.rx.tap.bind(to: didTapOnNextButton).disposed(by: disposeBag)
    }
}
