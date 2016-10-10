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

    /// Stops corresponding controller and returns back to previous one
    func stop()

    /// Called when segue navigation form corresponding controller to different controller is about to start and should handle this navigation
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?)
}

/// Navigate and stop methods are optional
extension Coordinator {
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
    }

    func stop() {
    }
}

protocol DefaultCoordinator: Coordinator {
    associatedtype VC: UIViewController
    weak var viewController: VC? { get set }

    var animated: Bool { get }
    weak var delegate: CoordinatorDelegate? { get }
}

protocol PushCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
}

protocol ModalCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
    weak var destinationNavigationController: UINavigationController? { get }
}

protocol PushModalCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController? { get }
    weak var destinationNavigationController: UINavigationController? { get }
}

extension DefaultCoordinator {
    // default implementation if not overriden
    var animated: Bool {
        get {
            return true
        }
    }

    // default implementation of nil delegate, should be overriden when needed
    weak var delegate: CoordinatorDelegate? {
        get {
            return nil
        }
    }
}

extension PushCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }

        configuration?(viewController)
        viewController.setCoordinator(self)
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension ModalCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }

        configuration?(viewController)
        viewController.setCoordinator(self)

        if let destinationNavigationController = destinationNavigationController {
            navigationController.present(destinationNavigationController, animated: animated, completion: nil)
        }
    }
}

extension PushModalCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }

        configuration?(viewController)
        viewController.setCoordinator(self)

        if let destinationNavigationController = destinationNavigationController {
            // wrapper navigation controller means VC should be presented modally
            navigationController?.present(destinationNavigationController, animated: animated, completion: nil)
        } else {
            // present controller normally (initializer for this case not implemented, just an exploration of a possible future case)
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}


protocol CoordinatorDelegate: class {
    func willStop(in coordinator: Coordinator)
    func didStop(in coordinator: Coordinator)
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
