//
//  EpisodeCreateViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import UIKit

class EpisodeCreateViewController: UIViewController, Coordinated {

    var viewModel: EpisodeCreateViewModel!
    var coordinator: EpisodeCreateCoordinator?

    func getCoordinator() -> Coordinator? {
        return coordinator
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? EpisodeCreateCoordinator
    }

    @IBOutlet weak var nameTextField:  UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func save() {
        _ = viewModel.save().then { _ -> Void in
            self.coordinator?.stop()
            }.catch { err in
            print(err)
        }
    }

    @IBAction func cancel() {
        coordinator?.stop()
    }
}
