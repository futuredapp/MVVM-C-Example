//
//  SeasonTableViewCell.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 15.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import UIKit
import Bond
import ReactiveKit

class ObservingTableViewCell: UITableViewCell {

    var onReuseBag: DisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        onReuseBag.dispose()
    }
}

extension ObservingTableViewCell {
    func configure(_ viewModel: SeasonDetailViewModel) {
        if let label = textLabel {
            viewModel.title.bind(to: label.bnd_text).disposeIn(onReuseBag)
        }
    }
}

extension ObservingTableViewCell {
    func configure(_ viewModel: EpisodeDetailViewModel) {
        if let label = textLabel {
            viewModel.title.bind(to: label.bnd_text).disposeIn(onReuseBag)
        }
    }
}
