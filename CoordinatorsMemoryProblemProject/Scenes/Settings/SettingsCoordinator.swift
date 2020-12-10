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
        
//        viewModel.didTapOnNextButton.bind { [weak self] in
//            
//        }.disposed(by: disposeBag)

        return router.rx.push(controller, isAnimated: true)
    }
}
