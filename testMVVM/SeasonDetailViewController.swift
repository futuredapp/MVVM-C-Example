
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "CreateEpisode" {
            guard let vc = (segue.destination as? UINavigationController)?.viewControllers.first as? EpisodeCreateViewController   else {
                assertionFailure("segue \(segue.identifier) destination vc is not SeasonDetailViewController")
                return
            }

            vc.viewModel = EpisodeCreateViewModel(seasonDetailViewModel: viewModel)
        }

        super.prepare(for: segue, sender: sender)
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


