//
//  SeasonDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation

class SeasonDetailViewModel {
    
    private var model : Season
    
    var title : String?
    private var episodes : [EpisodeDetailViewModel]!
    
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
    
    func getEpisode(indexPath: NSIndexPath) -> EpisodeDetailViewModel {
        return episodes[indexPath.row]
    }
    
    func playEpisode(indexPath: NSIndexPath) {
        episodes[indexPath.row].play()
        print("playing \(episodes[indexPath.row].title)")
    }
    
    func stopPlayingEpisode(indexPath: NSIndexPath) {
        episodes[indexPath.row].stop()
        print("stop playing \(episodes[indexPath.row].title!) played \(episodes[indexPath.row].played)")
        
    }
    
}