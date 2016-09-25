//
//  ViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import UIKit

class SeasonsViewController: BaseController, Coordinated {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: SeasonsTableViewModel!
    var coordinator: SeasonsTableCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        tableView.reloadData()
    }

    func getCoordinator() -> Coordinator? {
        return coordinator
    }
}

extension SeasonsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showEpisodes(viewModel: viewModel.seasonForIndexPath(indexPath))
    }
}

extension SeasonsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberOfSeasons()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.configure(viewModel.seasonForIndexPath(indexPath))
        return cell
    }
}


extension UITableViewCell {

    func configure(_ model: SeasonDetailViewModel) {
        textLabel?.text = model.title
    }
}
