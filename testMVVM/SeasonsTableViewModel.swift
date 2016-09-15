//
//  SeasonsTableViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation


class SeasonsTableViewModel {

    var seasonsServices : SeasonsServices!
    fileprivate var seasons: [SeasonDetailViewModel] = []
    
    init(seasonsServices: SeasonsServices) {
        self.seasonsServices = seasonsServices
        load()
    }
    
    func load() {
        seasons = seasonsServices.getSeasons().map(SeasonDetailViewModel.init)
    }

    func seasonForIndexPath(_ indexPath: IndexPath) -> SeasonDetailViewModel {
        return seasons[(indexPath as NSIndexPath).row]
    }
    
    func numberOfSeasons() -> Int {
        return seasons.count
    }
}
