//
//  EpisodeDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation

class EpisodeDetailViewModel {

    
    fileprivate var model: Episode

    var title: String?
    var isPlaying : Bool = false
    
    var played: Bool {
        return model.played
    }
    
    init(model: Episode) {
        self.model = model
        configure()
    }
    
    
    func play() {
        if !isPlaying {
            model.played = true
            isPlaying = true
        }
    }
    
    func stop() {
        isPlaying = false
    }

    func configure() {
        title = model.name 
    }
}
