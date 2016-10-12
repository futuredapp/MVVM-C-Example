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
        let tabBarCoordinator = TabBarCoordinator(window: window)
        tabBarCoordinator.start()
    }

    func showAuth() {
        // Authentication coordinator initialization
    }
}
