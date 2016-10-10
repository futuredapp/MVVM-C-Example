//
//  SeasonDetailCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class SeasonDetailCoordinator: PushCoordinator {
    lazy internal var configuration: ((SeasonDetailViewController) -> ())? = { vc in
        vc.viewModel = self.viewModel
    }

    internal var navigationController: UINavigationController
    let viewModel: SeasonDetailViewModel
    internal weak var viewController: SeasonDetailViewController?

    /// Used for initialization without segue
    init(navigationController: UINavigationController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as? SeasonDetailViewController
    }

    /// Used for initialization with segue
    init(navigationController: UINavigationController, viewController: SeasonDetailViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }

    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
        if let navigation = source.navigationController, let destination = destination as? UINavigationController, let viewController = destination.topViewController as? EpisodeCreateViewController, let viewModel = sender as? SeasonDetailViewModel, identifier == "createSegue" {
            let coordinator = EpisodeCreateCoordinator(navigationController: navigation, destinationNavigationController: destination, viewController: viewController, viewModel: viewModel)
            coordinator.delegate = self
            coordinator.start()
        }        
    }

    func showCreateEpisode(from viewModel: SeasonDetailViewModel) {
        viewController?.performSegue(withIdentifier: "createSegue", sender: viewModel)
    }
}

extension SeasonDetailCoordinator: EpisodeCreateCoordinatorDelegate {
    internal func willStop(in coordinator: EpisodeCreateCoordinator) {
        
    }

    func didStop(in coordinator: EpisodeCreateCoordinator) {
        print("create coordinator finished")
    }
}
