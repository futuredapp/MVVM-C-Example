//
//  EpisodeDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation

class EpisodeDetailViewModel {
    
    private var model: Episode

    var title: String?
    
    init(model: Episode) {
        self.model = model
        configure()
    }
    
    func configure() {
        title = model.name 
    }
    
    
}