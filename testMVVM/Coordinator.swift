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

/// Used typically on view controllers to refer to it's coordinator
protocol Coordinated {
    func getCoordinator() -> Coordinator?
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
