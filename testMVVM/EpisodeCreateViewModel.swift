//
//  EpisodeCreateViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import PromiseKit

class EpisodeCreateViewModel {

    enum EpisodeCreate: Error {
       case WrongName
    }

    fileprivate var seasonService: SeasonsServices
    fileprivate var season : Season

    var name: String?

    init(season: Season, seasonService: SeasonsServices) {
        self.season = season
        self.seasonService = seasonService
    }

    func save() -> Promise<Void> {

        return firstly { _ -> Promise<Episode> in
            guard let name = name, name != "" else {
                throw EpisodeCreate.WrongName
            }

            return seasonService.create(episode: Episode(name: name), inSeason: season)
            }.then { episode -> Void in
         
        }

    }

}
