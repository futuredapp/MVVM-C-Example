//
//  EpisodeCreateViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import UIKit

class EpisodeCreateViewController: UIViewController {

    var viewModel: EpisodeCreateViewModel!

    @IBOutlet weak var nameTextField:  UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func save() {

        _ = viewModel.save().then { _ -> Void in
            self.dismiss(animated: true, completion: nil)
            }.catch { err in
            print(err)
        }
    }

    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
