//
//  BaseViewModel.swift
//  ios-swift-template
//
//  Created by Charles Prado on 10/12/2019.
//  Copyright © 2019 Bliss Applications. All rights reserved.
//

// Note: Do not add any UI frameworks (like UIKit or SwiftUI) imports here.

import RxSwift
import RxCocoa

public protocol ViewModelType {
    var disposeBag: DisposeBag { get set }
}

open class BaseViewModel: ViewModelType {

    public var disposeBag = DisposeBag()
    public var didTriggerDeveloperToolsObservable = PublishSubject<Void>()
    public var didDismissedModal = PublishSubject<Void>()

    required public init() {
        bindObservables()
    }
    
    func load() {
        fatalError("Subclasses must override AND NOT CALL super")
    }

    open func bindObservables() {}
    
//    public func subscribePropagatingErrors<T>(to single: Single<T>,
//                                  onSuccess: ((T) -> Void)? = nil,
//                                  onError: ((Error) -> Void)? = nil) -> Disposable {
//        
//        return single.subscribe(onSuccess: { element in
//            onSuccess?(element)
//        }, onError: { [weak self] (error) in
//            onError?(error)
//            self?.state.accept(.error(error))
//        })
//    }
}
