
import UIKit
import RxSwift

public protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    public var viewController: UIViewController? { return self }
}

//

public typealias NavigationClosure = (() -> ())

protocol RouterProtocol: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationClosure?)

    func present(_ drawable: Drawable,
                 isAnimated: Bool,
                 onDismissed closure: NavigationClosure?)
    
    func popToViewController(_ viewController: UIViewController, animated: Bool)
}

//

public enum RouterFlowType {
    case present
    case push
}

public class Router: NSObject, RouterProtocol {
    func popToViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }
    
    
    public var flowType: RouterFlowType = .push
    private let shouldHideBackButton: Bool = false

    let navigationController: UINavigationController
    private var closures: [String: NavigationClosure] = [:]

    public init(navigationController: UINavigationController,
                flowType: RouterFlowType = .push,
                shouldHideBackButton: Bool = false) {

        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    public func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationClosure?) {
        guard let viewController = drawable.viewController else {
            return
        }

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }

    public func present(_ drawable: Drawable,
                        isAnimated: Bool,
                        onDismissed closure: NavigationClosure?) {
        guard let viewController = drawable.viewController else {
            return
        }

        viewController.presentationController?.delegate = self

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }

        navigationController.present(viewController, animated: isAnimated)
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension Router: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(presentationController.presentedViewController)
    }
}

extension Router: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

extension Reactive where Base: Router {

    public func push(_ drawable: Drawable, isAnimated: Bool) -> Observable<Void> {
        Observable.create({ [weak base] observer -> Disposable in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }

            base.push(drawable, isAnimated: isAnimated, onNavigateBack: {
                observer.onNext(())
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    public func present(_ drawable: Drawable, isAnimated: Bool) -> Observable<Void> {
        Observable.create({ [weak base] observer -> Disposable in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }

            base.present(drawable, isAnimated: isAnimated, onDismissed: {
                observer.onNext(())
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    public func navigate(to controller: UIViewController, bottomSheetPreferredHeight: CGFloat = 0.0) -> Observable<Void> {
        switch base.flowType {
        case .present:
            return present(controller, isAnimated: true)
        case .push:
            return push(controller, isAnimated: true)
        }
    }
}
