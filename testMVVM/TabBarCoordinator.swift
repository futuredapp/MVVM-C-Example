//
//  TabBarCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 06.10.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {

    let window: UIWindow
    let serviceHolder: ServiceHolder

    init(window: UIWindow, services: ServiceHolder) {
        self.window = window
        self.serviceHolder = services
    }

    func start() {
        let tabBarController = UITabBarController()

        let seasonsCoordinator = SeasonsCoordinator(services: serviceHolder)
        seasonsCoordinator.start()
        let anotherCoordiantor = AnotherCoordinator(services: serviceHolder)
        anotherCoordiantor.start()

        tabBarController.setViewControllers([seasonsCoordinator.navigationController!, anotherCoordiantor.viewController!], animated: false)

        window.rootViewController = tabBarController
    }
}
