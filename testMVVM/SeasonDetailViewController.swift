
//
//  SeasonDetailViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import UIKit

class SeasonDetailViewController: BaseController, Coordinated {

    @IBOutlet var tableView: UITableView!

    var viewModel: SeasonDetailViewModel!
    var coordinator: SeasonDetailCoordinator?

    func getCoordinator() -> Coordinator? {
        return coordinator
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? SeasonDetailCoordinator
    }

    @IBAction func handleCreateEpisodeButtonTap() {
        coordinator?.showCreateEpisode(from: viewModel)
    }
}

extension SeasonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEpisodes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ObservingTableViewCell(style: .default, reuseIdentifier: nil)
        cell.configure(viewModel.getEpisode(indexPath))
        return cell
    }
}

extension SeasonDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        viewModel.playEpisode(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.stopPlayingEpisode(indexPath)
    }
}


