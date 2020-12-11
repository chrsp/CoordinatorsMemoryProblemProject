//
//  BaseCoordinator.swift
//  CoordinatorsMemoryProblemProject
//

import Foundation
import RxSwift

open class BaseCoordinator<ResultType> {

    typealias CoordinationResult = ResultType

    public let disposeBag: DisposeBag = DisposeBag()
    
    let router: Router
    
    let identifier = UUID()
    var childCoordinators = [UUID: Any]()
    var parentCoordinator: Any?
    
    public init(router: Router) {
        self.router = router
    }

    private func store<T>(coordinator: BaseCoordinator<T>) {
        coordinator.parentCoordinator = self
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    public func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
    }

    open func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}
