

import Foundation
import RxSwift

public class AppCoordinator: BaseCoordinator<Void> {

    let window: UIWindow
    
    private var windowScene: Any?

    public init(window: UIWindow) {
        self.window = window
    }
    
    override public func start() -> Observable<Void> {
        
        let viewModel = IntroViewModel()
        let viewController = GenericViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let router = Router(navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.didTapOnNextButton.bind { [weak self] in
            guard let self = self else { return }
            let destinationCoordinator = OnboardingSceneOneCoordinator(router: router)
            self.coordinate(to: destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        SessionManager.shared.didFinishSession.bind {
            viewController.navigationController?.popToViewController(viewController, animated: true)
        }.disposed(by: disposeBag)

        return Observable.never()
    }
}

