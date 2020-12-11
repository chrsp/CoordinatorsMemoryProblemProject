//
//  BaseCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import Foundation
import RxSwift

protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    func start() -> Observable<Void>
}

open class BaseCoordinator: Coordinator {

    public let disposeBag: DisposeBag = DisposeBag()
    
    let router: Router
    
    let identifier = UUID()
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Any?
    
    public init(router: Router) {
        self.router = router
    }

    private func store(coordinator: Coordinator) {
        //coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
    }

    private func free(coordinator: Coordinator?) {
        childCoordinators.removeAll()
    }

    func coordinate(_ coordinator: Coordinator) -> Observable<Void> {
        self.store(coordinator: coordinator)
        return coordinator
            .start()
            .do(onNext: { [weak self, weak coordinator] _ in
                self?.free(coordinator: coordinator)
            })
    }

    open func start() -> Observable<Void> {
        fatalError("Start method should be implemented.")
    }
}
