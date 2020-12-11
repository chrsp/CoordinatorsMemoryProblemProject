//
//  AuthCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class SettingsCoordinator: BaseCoordinator<Void> {
    
    var router: Router

    public init(router: Router) {
        self.router = router
        super.init()
    }

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
