//
//  SeasonService.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import PromiseKit

protocol SeasonsServices {    
    func seasons() -> Promise<[Season]>
    func create(episode:Episode, inSeason season: Season) -> Promise<Episode>
    func update(episode: Episode, name: String?) -> Promise<Episode>
}

class TestSeasonsServices: SeasonsServices {
    
    func seasons() -> Promise<[Season]> {
        return Promise { fulfill, reject in
            fulfill([Season(name: "season 1", episodes: [Episode(name:"aa"), Episode(name:"ab")])])
        }
    }

    func create(episode:Episode, inSeason season: Season) -> Promise<Episode> {
        return Promise { fulfill, reject in
            season.episodes.append(episode)
            fulfill(episode)
        }
    }

    func update(episode: Episode, name: String?) -> Promise<Episode> {
        return Promise { fulfill, reject in
            episode.name = name
            fulfill(episode)
        }
    }
}
