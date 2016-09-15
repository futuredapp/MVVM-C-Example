
//
//  SeasonDetailViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import UIKit

class SeasonDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var viewModel: SeasonDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

extension SeasonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEpisodes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
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

extension UITableViewCell {

    func configure(_ viewModel: EpisodeDetailViewModel) {
        textLabel?.text = viewModel.title
    }
}
