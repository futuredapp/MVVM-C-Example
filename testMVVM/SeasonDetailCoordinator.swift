//
//  SeasonDetailCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class SeasonDetailCoordinator: Coordinator {

    let navigationController: UINavigationController?
    let viewModel: SeasonDetailViewModel
    
    weak var viewController: SeasonDetailViewController?

    /// Used for initialization without segue
    init(navigationController: UINavigationController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }

    /// Used for initialization with segue
    init(navigationController: UINavigationController, viewController: SeasonDetailViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }

    func start() {
        // In this case we support both kinds of coordination - with and without segues. When coordinated without segue, self.viewController is nil and we need to instantiate it
        if viewController == nil {
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as? SeasonDetailViewController
        }
        viewController!.viewModel = self.viewModel
        viewController!.coordinator = self
        navigationController?.pushViewController(viewController!, animated: true)
    }

    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
        if let navigation = source.navigationController, let destination = destination as? UINavigationController, let viewController = destination.topViewController as? EpisodeCreateViewController, let viewModel = sender as? SeasonDetailViewModel, identifier == "createSegue" {
            let coordinator = EpisodeCreateCoordinator(navigationController: navigation, wrapperNavigationController: destination, viewController: viewController, viewModel: viewModel)
            coordinator.start()
        }        
    }

    func showCreateEpisode(from viewModel: SeasonDetailViewModel) {
        viewController?.performSegue(withIdentifier: "createSegue", sender: viewModel)
    }
}

extension SeasonDetailCoordinator: EpisodeCreateCoordinatorDelegate {
    func didStop(in coordinator: EpisodeCreateCoordinator) {
        print("create coordinator finished")
    }
}
