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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.identifier == "showEpisodes" {
            let vc = segue.destinationViewController as! SeasonDetailViewController
            vc.viewModel = sender as! SeasonDetailViewModel
        }
    }
    
}

extension SeasonsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showEpisodes", sender: viewModel.seasonForIndexPath(indexPath))
    }
}

extension SeasonsViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberOfSeasons()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        cell.configure(viewModel.seasonForIndexPath(indexPath))
        return cell
    }
    
}


extension UITableViewCell {

    func configure(model: SeasonDetailViewModel) {
        textLabel?.text = model.title
    }
}