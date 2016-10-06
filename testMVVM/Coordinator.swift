//
//  Coordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

protocol Coordinator {
    /// Triggers navigation to the corresponding controller
    func start()

    /// Called when segue navigation form corresponding controller to different controller is about to start and should handle this navigation
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?)
}

/// Navigate method is optional as in some cases we needn't use segues
extension Coordinator {
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
    }
}

protocol DefaultCoordinator: Coordinator {
    associatedtype VC: UIViewController
    weak var viewController: VC? { get set }
}

protocol PushCoordinator: DefaultCoordinator {
    var config: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
}

protocol ModalCoordinator: DefaultCoordinator {
    var config: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
    weak var wrapperNavigationController: UINavigationController? { get }
}

protocol PushModalCoordinator: DefaultCoordinator {
    var config: ((VC) -> ())? { get }
    var navigationController: UINavigationController? { get }
    weak var wrapperNavigationController: UINavigationController? { get }
}

extension PushCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }

        config?(viewController)
        viewController.setCoordinator(self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ModalCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }

        config?(viewController)
        viewController.setCoordinator(self)

        if let wrapperNavigationController = wrapperNavigationController {
            navigationController.present(wrapperNavigationController, animated: true, completion: nil)
        }
    }
}

extension PushModalCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }

        config?(viewController)        
        viewController.setCoordinator(self)

        if let wrapperNavigationController = wrapperNavigationController {
            // wrapper navigation controller means VC should be presented modally
            navigationController?.present(wrapperNavigationController, animated: true, completion: nil)
        } else {
            // present controller normally (initializer for this case not implemented, just an exploration of a possible future case)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


/// Used typically on view controllers to refer to it's coordinator
protocol Coordinated {
    func getCoordinator() -> Coordinator?
    func setCoordinator(_ coordinator: Coordinator)
}

class CoordinatorSegue: UIStoryboardSegue {

    open var sender: AnyObject!

    override func perform() {
        guard let source = self.source as? Coordinated else {
            return
        }

        source.getCoordinator()?.navigate(from: self.source, to: destination, with: identifier, and: sender)
    }
}
