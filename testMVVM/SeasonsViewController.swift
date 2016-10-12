//
//  ViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import UIKit
import Bond

class SeasonsViewController: BaseController, Coordinated {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: SeasonsTableViewModel!
    var coordinator: SeasonsCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = viewModel.load().then { (_) -> Void in
            self.tableView.reloadData()
        }
    }

    func getCoordinator() -> Coordinator? {
        return coordinator
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? SeasonsCoordinator
    }
}

extension SeasonsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showEpisodes(from: viewModel.seasonForIndexPath(indexPath))
    }

}

extension SeasonsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberOfSeasons()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ObservingTableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.configure(viewModel.seasonForIndexPath(indexPath))
        return cell
    }
    
}
