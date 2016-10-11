//
//  Model.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation

class Season {
    
    var name: String? //should be observable
    var episodes: [Episode] //should be observable

    init(name: String, episodes: [Episode]) {
        self.name = name
        self.episodes = episodes
    }
}

class Episode {

    var id: String?
    var name: String? //should be observable
    var played: Bool = false //should be observable
    
    init(name: String) {
        self.name = name
    }

    init(withId id: String) {
        self.id = id
    }    
}
