//
//  AppCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        // Login state detection
        let loggedIn = true

        if (loggedIn) {
            showSeasons()
        } else {
            showAuth()
        }
    }

    func showSeasons() {
        let seasonsCoordinator = SeasonsTableCoordinator(window: window)
        seasonsCoordinator.start()
    }

    func showAuth() {
        // Authentication coordinator initialization
    }
}
