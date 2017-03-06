//
//  AppCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

/// Main entry point to the app
class AppCoordinator: Coordinator {

    let window: UIWindow
    let serviceHolder: ServiceHolder = {
        let helper = ServiceHolder()
        helper.add(SeasonsServices.self, for: TestSeasonsServices.self)
        return helper
    }()
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        // Login state detection
        let loggedIn = true

        if (loggedIn) {
            showTabBar()
        } else {
            showAuth()
        }
    }

    func showTabBar() {
        let tabBarCoordinator = TabBarCoordinator(window: window, services: serviceHolder)
        tabBarCoordinator.start()
    }

    func showAuth() {
        // TODO: Authentication coordinator initialization
    }
}
