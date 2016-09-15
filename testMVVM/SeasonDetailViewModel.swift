//
//  SeasonDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation

class SeasonDetailViewModel {
    
    fileprivate var model : Season
    
    var title : String?
    fileprivate var episodes : [EpisodeDetailViewModel]!
    
    init(model: Season) {
        self.model = model
        
        configure()
    }
    
    func configure() {
        title = model.name
        episodes = model.episodes.map(EpisodeDetailViewModel.init)
    }
    
    func numberOfEpisodes() -> Int {
        return episodes.count
    }
    
    func getEpisode(_ indexPath: IndexPath) -> EpisodeDetailViewModel {
        return episodes[(indexPath as NSIndexPath).row]
    }
    
    func playEpisode(_ indexPath: IndexPath) {
        episodes[(indexPath as NSIndexPath).row].play()
        print("playing \(episodes[(indexPath as NSIndexPath).row].title)")
    }
    
    func stopPlayingEpisode(_ indexPath: IndexPath) {
        episodes[(indexPath as NSIndexPath).row].stop()
        print("stop playing \(episodes[(indexPath as NSIndexPath).row].title) played \(episodes[(indexPath as NSIndexPath).row].played)")
        
    }
    
}
