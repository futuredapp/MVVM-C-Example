//
//  SeasonDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import Bond
import PromiseKit
import ReactiveKit

class SeasonDetailViewModel {
    
    fileprivate var model : Season
    fileprivate var service: SeasonsServices
    let title : Observable<String> = Observable("")

    fileprivate var episodes : Observable<[EpisodeDetailViewModel]> = Observable([])
    
    init(model: Season, seasonServices: SeasonsServices) {
        self.model = model
        self.service = seasonServices
        configure()
    }
    
    func configure() {
        title.value = model.name ?? ""
        episodes.value = model.episodes.map(EpisodeDetailViewModel.init)
    }
    
    func numberOfEpisodes() -> Int {
        return episodes.value.count
    }
    
    func getEpisode(_ indexPath: IndexPath) -> EpisodeDetailViewModel {
        return episodes.value[(indexPath as NSIndexPath).row]
    }

    func playEpisode(_ indexPath: IndexPath) {
        episodes.value[(indexPath as NSIndexPath).row].play()
        print("playing \(episodes.value[(indexPath as NSIndexPath).row].title)")
    }
    
    func stopPlayingEpisode(_ indexPath: IndexPath) {
        episodes.value[(indexPath as NSIndexPath).row].stop()
        print("stop playing \(episodes.value[(indexPath as NSIndexPath).row].title) played \(episodes.value[(indexPath as NSIndexPath).row].played)")
    }

    func setTitle(title: String) {
        self.title.value = title
        self.model.name = title
    }
}

extension EpisodeCreateViewModel {

    convenience init(seasonDetailViewModel: SeasonDetailViewModel) {
        self.init(season: seasonDetailViewModel.model, seasonService: TestSeasonsServices())
    }
}
