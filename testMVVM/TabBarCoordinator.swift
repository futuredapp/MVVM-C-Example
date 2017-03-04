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
    let serviceHelper: ServiceHolder

    init(window: UIWindow, services: ServiceHolder) {
        self.window = window
        self.serviceHelper = services
    }

    func start() {
        let tabBarController = UITabBarController()

        let seasonsCoordinator = SeasonsCoordinator(services: serviceHelper)
        seasonsCoordinator.start()
        let anotherCoordiantor = AnotherCoordinator(services: serviceHelper)
        anotherCoordiantor.start()

        tabBarController.setViewControllers([seasonsCoordinator.navigationController!, anotherCoordiantor.viewController!], animated: false)

        window.rootViewController = tabBarController
    }
}
