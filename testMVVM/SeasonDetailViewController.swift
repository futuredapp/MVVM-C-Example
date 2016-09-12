
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getEpisodesCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.configure(viewModel.getEpisode(indexPath))
        return cell
    }
}


extension UITableViewCell {

    func configure(viewModel: EpisodeDetailViewModel) {
        textLabel?.text = viewModel.title
    }
}