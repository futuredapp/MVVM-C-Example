//
//  Model.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation

struct Season {
    
    var name: String
    var episodes: [Episode]
    
}

struct Episode {
    
    var name: String
    var played: Bool = false
    
    init(name: String) {
        self.name = name
    }
    
}