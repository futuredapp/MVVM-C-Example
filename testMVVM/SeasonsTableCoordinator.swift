//
//  SeaonsTableCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class SeasonsTableCoordinator: Coordinator {

    var window: UIWindow
    var viewController: SeasonsViewController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as? SeasonsViewController
        viewController?.viewModel = SeasonsTableViewModel(seasonsServices: TestSeasonsServices())
        viewController?.coordinator = self
        window.rootViewController = navigationController
    }

    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
        if let navigation = source.navigationController, let destination = destination as? SeasonDetailViewController, let viewModel = sender as? SeasonDetailViewModel, identifier == "showEpisodes" {
            let coordinator = SeasonDetailCoordinator(navigationController: navigation, viewController: destination, viewModel: viewModel)
            coordinator.start()
        }
    }

    func showEpisodes(viewModel: SeasonDetailViewModel) {
        viewController?.performSegue(withIdentifier: "showEpisodes", sender: viewModel)


        // ** demonstration of a second option of VC initialization -- without use of a segue ** 
        //let destinationCoordinator = SeasonDetailCoordinator(navigationController: viewController!.navigationController!, viewModel:viewModel)
        //destinationCoordinator.start()
    }
}
