//
//  SeasonDetailCoordinator.swift
//  MVVMTestProject
//
//  Created by Petr Zvoníček on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import UIKit

class SeasonDetailCoordinator: Coordinator {

    var navigationController: UINavigationController?
    var viewController: SeasonDetailViewController?
    var viewModel: SeasonDetailViewModel

    init(navigationController: UINavigationController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }

    init(navigationController: UINavigationController, viewController: SeasonDetailViewController, viewModel: SeasonDetailViewModel) {
        self.navigationController = navigationController
        self.viewController = viewController
        self.viewModel = viewModel
    }

    func start() {
        if viewController == nil {
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as? SeasonDetailViewController
        }
        viewController!.viewModel = self.viewModel
        viewController!.coordinator = self
        navigationController?.pushViewController(viewController!, animated: true)
    }
}
