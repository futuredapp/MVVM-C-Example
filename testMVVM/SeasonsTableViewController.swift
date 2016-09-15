//
//  ViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: SeasonsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SeasonsTableViewModel(seasonsServices: TestSeasonsServices())
        viewModel.load()
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showEpisodes" {
            guard let vc = segue.destination as? SeasonDetailViewController, let viewModel = sender as? SeasonDetailViewModel  else {
                assertionFailure("segue \(segue.identifier) destination vc is not SeasonDetailViewController")
                return
            }

            vc.viewModel = viewModel
        }
    }
    
}

extension SeasonsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showEpisodes", sender: viewModel.seasonForIndexPath(indexPath))
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
