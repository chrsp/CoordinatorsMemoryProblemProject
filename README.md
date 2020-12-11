# CoordinatorsMemoryProblemProject

[UPDATE 2020/12/11: A solution for this problem was added in the branch `feature/new-coordinators-model`. However, that's changes the way the Coordinators works. Before this the Coordinators as Generic classes that was able to pass data to its caller by using the `subscribe(onNext: )` method. With this solution, this is not possible anymore].

This project was created to describe a possible problem in the usage of Coordinators (in this case, with RxSwift).

The Project has 5 screens: Intro, Onboarding 1, Onboarding 2, Home and Settings.

![](resources/problem.gif)

The problem I'm trying to solve here is: how to dispose multiple objects from memory when they aren't needed anymore, if I'm using the coordinator pattern?

There's two scenarios to be tested here:

1 - The app goes from Onboarding to the Home screen. In this case, it is expected that the app stays at the Home Screen but dispose all Onboarding objects (Coordinators, Controllers, ViewModels and Views) from memory. If the user press the back button in the Home Screen it should back to the Intro Screen instead to the Onboarding.

2 - The user press the "Log Out" button in Settings Screen. In this case is expected that the app goes to the first screen (Intro) and dispose all objects from memory, restarting the app flow.

Regarding the ViewControllers, the navigation stack could be changed directly to accomplish what are described in theses two scenarios. This way it's possible to remove the onboarding screens, like mentioned in (1), and remove all screens, as mentioned in (2). However, doing that, the Coordinators keep retained in memory, and that is the problem here.

Some approachs were thought to solve this problem here:

1 - Having a Singleton (`SessionManager`) that will have a observable that will control if the user pressed the logout button. In this case, the AppCoordinator will be listen to that event and will `popToRootViewController` when it's triggered:
```
        SessionManager.shared.didFinishSession.bind {
            viewController.navigationController?.popToViewController(viewController, animated: true)
        }.disposed(by: disposeBag)
```

Also, all the coordinators must have this observable being used to determine that the Coordinator was finished. So, in each Coordinator:
```
        return Observable.merge(router.rx.push(controller, isAnimated: true),
                                SessionManager.shared.didFinishSession.take(1))
```

This, in theory, solves the problem 2, but not the problem 1.

NOTE: The approach 1 was implemented in branch `feature/singleton-idea`. It didn't resulted well.

2 - Having a method `popToCoordinator` that should works like a `popToViewController`, but instead of working with controllers here, we also work with coordinators. In this case, the solution should work in a way that the code is able to identify the coordinator passed in memory, and goes disposing each coordinator before it until it reaches to the desired coordinator. In the current structure I still have no idea to how implement this approach cause to have it working, it was needed to have a referrence to the `parentCoordinator` inside each coordinator (added on the `BaseCoordinator`). That was an idea still being considered.
