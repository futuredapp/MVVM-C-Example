//
//  SeasonsTableViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import Bond
import PromiseKit

class SeasonsTableViewModel {

    let seasonsServices : SeasonsServices
    let seasons: Observable<[SeasonDetailViewModel]> = Observable([])
    
    init(seasonsServices: SeasonsServices) {
        self.seasonsServices = seasonsServices
    }

    @discardableResult
    func load() -> Promise<[SeasonDetailViewModel]>  {
        return Promise { fulfill, reject in
            seasonsServices.seasons().then { seasons -> Void in
                self.seasons.value = seasons.map {
                    SeasonDetailViewModel(model: $0, seasonServices: self.seasonsServices)
                }
                fulfill(self.seasons.value)

            }.catch { err in
                reject(err)
            }
        }
    }

    func seasonForIndexPath(_ indexPath: IndexPath) -> SeasonDetailViewModel {
        return seasons.value[indexPath.row]
    }
    
    func numberOfSeasons() -> Int {
        return seasons.value.count
    }
}
