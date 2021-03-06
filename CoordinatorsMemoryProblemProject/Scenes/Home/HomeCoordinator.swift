//
//  HomeCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import RxSwift

class HomeCoordinator: BaseCoordinator<Void> {

    override public func start() -> Observable<Void> {

        let viewModel = HomeViewModel()
        let controller = GenericViewController(viewModel: viewModel)

        viewModel.didTapOnNextButton.bind { [weak self] in
            guard let self = self else { return }
            let destinationCoordinator = SettingsCoordinator(router: self.router)
            self.coordinate(to: destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        // MARK: - HERE, after the home was presented, the Scene one and Two objects should be disposed
        // from memory. The ViewControllers should be removed from the navigation stack, and the coordinators
        // should also be disposed.
        
        return Observable.merge(router.rx.push(controller, isAnimated: true),
                                SessionManager.shared.didFinishSession.take(1))
    }
}
