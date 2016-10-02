//
//  EpisodeDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import Bond

class EpisodeDetailViewModel {
    
    fileprivate var model: Episode

    let title: Observable<String> = Observable("")
    let isPlaying : Observable<Bool> = Observable(false)

    var played: Bool {
        return model.played
    }

    init(model: Episode) {
        self.model = model
        configure()
    }

    func play() {
        if !isPlaying.value {
            model.played = true
            isPlaying.value = true
        }
    }
    
    func stop() {
        isPlaying.value = false
    }

    func configure() {
        title.value = model.name ?? ""
    }
}
