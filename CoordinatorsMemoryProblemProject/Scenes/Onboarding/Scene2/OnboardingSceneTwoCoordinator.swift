//
//  SceneTwoCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class OnboardingSceneTwoCoordinator: BaseCoordinator {

    override public func start() -> Observable<Void> {

        let viewModel = OnboardingSceneTwoViewModel()
        let controller = GenericViewController(viewModel: viewModel)

        viewModel.didTapOnNextButton.bind { [weak self] in
            guard let self = self else { return }
            let destinationCoordinator = HomeCoordinator(router: self.router)
            self.coordinate(destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        return router.rx.push(controller, isAnimated: true)
    }
}
