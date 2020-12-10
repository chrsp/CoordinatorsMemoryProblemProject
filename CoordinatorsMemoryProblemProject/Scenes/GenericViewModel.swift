//
//  GenericViewModel.swift
//  CoordinatorsMemoryProblemProject
//
//  Created by Charles Prado on 10/12/2020.
//


import UIKit
import RxSwift

class GenericViewModel: BaseViewModel {
    let didTapOnNextButton = PublishSubject<Void>()
    
    open var title: String { "" }
    open var buttonTitle: String { "" }
}
