//
//  EpisodeCreateCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 25.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

// TODO: generalize
protocol EpisodeCreateCoordinatorDelegate: class {
    func willStop(in coordinator: EpisodeCreateCoordinator)
    func didStop(in coordinator: EpisodeCreateCoordinator)
}

class EpisodeCreateCoordinator: PushModalCoordinator {
    let navigationController: UINavigationController?
    let viewModel: SeasonDetailViewModel

    lazy internal var config: ((EpisodeCreateViewController) -> ())? = { vc in
        vc.viewModel = EpisodeCreateViewModel(seasonDetailViewModel: self.viewModel)
    }    

    weak var wrapperNavigationController: UINavigationController?
    weak var viewController: EpisodeCreateViewController?

    weak var delegate: EpisodeCreateCoordinatorDelegate?

    init(navigationController: UINavigationController, wrapperNavigationController: UINavigationController, viewController: EpisodeCreateViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.wrapperNavigationController = wrapperNavigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }

    func stop() {
        delegate?.willStop(in: self)
        viewController?.dismiss(animated: true, completion: { 
            delegate?.didStop(in: self)
        })
    }
}
