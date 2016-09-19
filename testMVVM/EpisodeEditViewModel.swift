//
//  EpisodeEditViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 19.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import PromiseKit
import Bond

class EpisodeEditViewModel {

    enum EpisodeEditViewModelError: Error {
        case NothingToUpdate
    }

    fileprivate var model : Episode
    fileprivate let service : SeasonsServices!

    var newTitle : String? {
        didSet {
            isSomethingToUpdate.value = true
        }
    }

    let isSomethingToUpdate = Observable(false)

    init(id: String, service: SeasonsServices) {
        model = Episode(withId: id)
        self.service = service
    }

    init(model: Episode, service: SeasonsServices) {
        self.model = model
        self.service = service
    }

    func save() -> Promise<Void> {

        return firstly { _ -> Promise<Episode> in
            if !isSomethingToUpdate.value {
                throw EpisodeEditViewModelError.NothingToUpdate
            }

            return service.update(episode: model, name: newTitle)

            }.then { episode -> Void in

        }

    }


}
