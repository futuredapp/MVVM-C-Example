//
//  TabBarCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 06.10.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class TabBarCoordinator: DefaultCoordinator {

    let window: UIWindow
    let serviceHelper: ServiceHelper

    weak var viewController: UITabBarController?

    init(window: UIWindow, services: ServiceHelper) {
        self.window = window
        self.viewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController)
        self.serviceHelper = services
    }

    func start() {
        if let seasonsNavigationController = self.viewController?.viewControllers?[0] as? UINavigationController, let seasonsViewController = seasonsNavigationController.topViewController as? SeasonsViewController {
            let seasonsCoordinator = SeasonsCoordinator(viewController: seasonsViewController, services: serviceHelper)
            seasonsCoordinator.start()
        }
//        if let abc = self.viewController?.viewControllers?[1] as? UINavigationController, let bbb = {
//            let fooCoord = ...
//            fooCoord.start()
//        }
        //.....
        // here goes coordinators for other tabs

        window.rootViewController = self.viewController

    }
}
