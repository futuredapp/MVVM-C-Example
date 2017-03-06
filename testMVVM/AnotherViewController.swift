//
//  AnotherController.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 02.03.17.
//  Copyright © 2017 Martin Pinka. All rights reserved.
//

import UIKit

class AnotherViewController: BaseController, Coordinated {

    var coordinator: AnotherCoordinator?

    func getCoordinator() -> Coordinator? {
        return coordinator
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? AnotherCoordinator
    }
}
