//
//  SceneOneCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class OnboardingSceneOneCoordinator: BaseCoordinator {

    override public func start() -> Observable<Void> {

        let viewModel = OnboardingSceneOneViewModel()
        let controller = GenericViewController(viewModel: viewModel)
        
        viewModel.didTapOnNextButton.bind { [weak self] in
            guard let self = self else { return }
            let destinationCoordinator = OnboardingSceneTwoCoordinator(router: self.router)
            self.coordinate(destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)

        return Observable.merge(router.rx.push(controller, isAnimated: true),
                                SessionManager.shared.didFinishSession.take(1))
    }
}
