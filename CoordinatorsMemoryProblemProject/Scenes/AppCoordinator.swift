

import Foundation
import RxSwift

public class AppCoordinator: BaseCoordinator<Void> {

    let window: UIWindow
    
    private var windowScene: Any?
    private let viewModel: IntroViewModel
    private let viewController: GenericViewController
    private let navigationController: UINavigationController

    public init(window: UIWindow) {
        self.window = window

        viewModel = IntroViewModel()
        viewController = GenericViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: viewController)
        
        let router = Router(navigationController: navigationController)
        
        super.init(router: router)
    }
    
    override public func start() -> Observable<Void> {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.didTapOnNextButton.bind { [weak self] in
            guard let self = self else { return }
            let destinationCoordinator = OnboardingSceneOneCoordinator(router: self.router)
            self.coordinate(to: destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        SessionManager.shared.didFinishSession.bind {
            self.router.popToViewController(self.viewController, animated: true)
        }.disposed(by: disposeBag)

        return Observable.never()
    }
}

