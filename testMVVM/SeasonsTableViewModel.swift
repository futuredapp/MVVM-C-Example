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
    var seasons: [SeasonDetailViewModel] = []
    
    init(seasonsServices: SeasonsServices) {
        self.seasonsServices = seasonsServices
    }
    
    func load() {
        seasons = seasonsServices.getSeasons().map(SeasonDetailViewModel.init)
    }
    
    func seasonForIndexPath(indexPath: NSIndexPath) -> SeasonDetailViewModel {
        return seasons[indexPath.row]
    }
}