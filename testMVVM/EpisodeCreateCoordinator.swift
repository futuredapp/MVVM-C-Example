//
//  EpisodeCreateCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 25.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class EpisodeCreateCoordinator: Coordinator {

    let navigationController: UINavigationController
    let viewModel: SeasonDetailViewModel

    let wrapperNavigationController: UINavigationController?
    var viewController: EpisodeCreateViewController

    init(navigationController: UINavigationController, wrapperNavigationController: UINavigationController, viewController: EpisodeCreateViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.wrapperNavigationController = wrapperNavigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }

    func start() {
        viewController.viewModel = EpisodeCreateViewModel(seasonDetailViewModel: viewModel)

        if let wrapperNavigationController = wrapperNavigationController {
            // wrapper navigation controller means VC should be presented modally
            navigationController.present(wrapperNavigationController, animated: true, completion: nil)
        } else {
            // present controller normally (initializer for this case not implemented, just an exploration of a possible future case)
            navigationController.pushViewController(viewController, animated: true)
        }
    }

}
