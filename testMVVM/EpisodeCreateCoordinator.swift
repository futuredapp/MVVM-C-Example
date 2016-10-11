//
//  EpisodeCreateCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 25.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class EpisodeCreateCoordinator: PushModalCoordinator {
    let navigationController: UINavigationController?
    let viewModel: SeasonDetailViewModel

    lazy internal var configuration: ((EpisodeCreateViewController) -> ())? = { vc in
        vc.viewModel = EpisodeCreateViewModel(seasonDetailViewModel: self.viewModel)
    }

    // uncomment to present controller without animation
    // var animated: Bool = false

    weak var destinationNavigationController: UINavigationController?
    weak var viewController: EpisodeCreateViewController?

    weak var delegate: CoordinatorDelegate?

    init(navigationController: UINavigationController, destinationNavigationController: UINavigationController, viewController: EpisodeCreateViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.destinationNavigationController = destinationNavigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
