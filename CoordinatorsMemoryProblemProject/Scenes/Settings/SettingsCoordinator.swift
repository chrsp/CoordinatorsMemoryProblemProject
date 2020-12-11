//
//  AuthCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class SettingsCoordinator: BaseCoordinator {
    
    override public func start() -> Observable<Void> {

        let viewModel = SettingsViewModel()
        let controller = GenericViewController(viewModel: viewModel)
        
        viewModel.didTapOnNextButton.bind { _ in
            SessionManager.shared.didFinishSession.onNext(())
        }.disposed(by: disposeBag)

        return router.rx.push(controller, isAnimated: true)
    }
}
