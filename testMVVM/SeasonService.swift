//
//  SeasonService.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation


protocol SeasonsServices {    
    func getSeasons() -> [Season]
}


class TestSeasonsServices: SeasonsServices {
    
    func getSeasons() -> [Season] {
        return [Season(name: "season 1", episodes: [Episode(name:"aa"), Episode(name:"ab")])]
    }
}