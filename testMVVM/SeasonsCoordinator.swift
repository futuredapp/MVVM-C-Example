//
//  SeaonsTableCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class SeasonsCoordinator: DefaultCoordinator {

    let serviceHolder: ServiceHolder

    weak var viewController: SeasonsViewController?
    weak var navigationController: UINavigationController?

    init(services: ServiceHolder) {
        self.serviceHolder = services
        self.navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController
        self.viewController = navigationController!.topViewController as? SeasonsViewController
    }

    func start() {
        viewController?.viewModel = SeasonsTableViewModel(seasonsServices: serviceHolder.get())
        viewController?.coordinator = self
    }

    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
        if let navigation = source.navigationController, let destination = destination as? SeasonDetailViewController, let viewModel = sender as? SeasonDetailViewModel, identifier == "showEpisodes" {
            let coordinator = SeasonDetailCoordinator(navigationController: navigation, viewController: destination, viewModel: viewModel)
            coordinator.start()
        }
    }

    func showEpisodes(from viewModel: SeasonDetailViewModel) {
        viewController?.performSegue(withIdentifier: "showEpisodes", sender: viewModel)


        // ** demonstration of a second option of VC initialization -- without use of a segue ** 
        //let destinationCoordinator = SeasonDetailCoordinator(navigationController: viewController!.navigationController!, viewModel:viewModel)
        //destinationCoordinator.start()
    }
}
