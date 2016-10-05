//
//  EpisodeCreateCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 25.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

protocol EpisodeCreateCoordinatorDelegate: class {
    func didStop(in coordinator: EpisodeCreateCoordinator)
}

class EpisodeCreateCoordinator: Coordinator {

    let navigationController: UINavigationController
    let viewModel: SeasonDetailViewModel

    weak var wrapperNavigationController: UINavigationController?
    weak var viewController: EpisodeCreateViewController?

    weak var delegate: EpisodeCreateCoordinatorDelegate?

    init(navigationController: UINavigationController, wrapperNavigationController: UINavigationController, viewController: EpisodeCreateViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.wrapperNavigationController = wrapperNavigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }

    func start() {
        guard let viewController = viewController else {
            return
        }

        viewController.viewModel = EpisodeCreateViewModel(seasonDetailViewModel: viewModel)
        viewController.coordinator = self
        
        if let wrapperNavigationController = wrapperNavigationController {
            // wrapper navigation controller means VC should be presented modally
            navigationController.present(wrapperNavigationController, animated: true, completion: nil)
        } else {
            // present controller normally (initializer for this case not implemented, just an exploration of a possible future case)
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    func stop() {
        delegate?.didStop(in: self)
        viewController?.dismiss(animated: true, completion: nil)
    }
}
