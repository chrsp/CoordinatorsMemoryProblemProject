//
//  AuthCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class SettingsCoordinator: BaseCoordinator<Void> {
    
    override public func start() -> Observable<Void> {

        let viewModel = SettingsViewModel()
        let controller = GenericViewController(viewModel: viewModel)
        
        viewModel.didTapOnNextButton.bind { [weak self] in
            SessionManager.shared.didFinishSession.onNext(())
        }.disposed(by: disposeBag)

        return Observable.merge(router.rx.push(controller, isAnimated: true),
                                SessionManager.shared.didFinishSession.take(1))
    }
}
