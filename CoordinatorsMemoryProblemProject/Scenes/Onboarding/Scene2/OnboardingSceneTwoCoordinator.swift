//
//  SceneTwoCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class OnboardingSceneTwoCoordinator: BaseCoordinator<Void> {
    
    var router: Router

    public init(router: Router) {
        self.router = router
        super.init()
    }

    override public func start() -> Observable<Void> {

        let viewModel = OnboardingSceneTwoViewModel()
        let controller = GenericViewController(viewModel: viewModel)

        viewModel.didTapOnNextButton.bind { [weak self] in
            guard let self = self else { return }
            let destinationCoordinator = HomeCoordinator(router: self.router)
            self.coordinate(to: destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        return Observable.merge(router.rx.push(controller, isAnimated: true),
                                SessionManager.shared.didFinishSession.take(1))
    }
}
