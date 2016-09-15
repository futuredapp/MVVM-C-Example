//
//  MVVMTestProjectTests.swift
//  MVVMTestProjectTests
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import XCTest

class Test1SeasonServices: SeasonsServices {
    
    func getSeasons() -> [Season] {
        let episodes = [Episode(name: "episode1"), Episode(name: "episode2"), Episode(name: "episode3")]
        return [Season(name: "blah", episodes: episodes)]
    }
}

class MVVMTestProjectTests: XCTestCase {
    
    let services = Test1SeasonServices()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLoadData() {
    
        let vm = SeasonsTableViewModel(seasonsServices: services)
    
        XCTAssert(vm.numberOfSeasons() == 1, "season 1 is missing")
        
        XCTAssert(vm.seasonForIndexPath(IndexPath(row: 0, section: 0)).title == "blah", "season 1 has wrong name")
        XCTAssert(vm.seasonForIndexPath(IndexPath(row: 0, section: 0)).numberOfEpisodes() == services.getSeasons()[0].episodes.count, "season has wrong number of episodes")
    }
    

    func getEpisode() -> EpisodeDetailViewModel {
        let vm  = SeasonsTableViewModel(seasonsServices: services)
        let indexPath = IndexPath(row: 0, section: 0)
        
        return vm.seasonForIndexPath(indexPath).getEpisode(indexPath)
    }
    
    func testGetEpisode() {
        
        let episode = getEpisode()
        
        XCTAssert(episode.title == "episode1" , "s01e01 is missing")
    }
    
    func testPlayEpisode() {
        let episode = getEpisode()
        episode.play()
        XCTAssert(episode.isPlaying, "should be playing")
    }
    
    func testEpisodeWasPlayed() {
        let episode = getEpisode()
        XCTAssert(!episode.played, "should not be played")
        
        episode.play()
        XCTAssert(episode.played, "should be played")
        
    }
 
    func testPlayAndStopEpisode() {
        let episodeVM = getEpisode()
    
        episodeVM.play()
        XCTAssert(episodeVM.isPlaying , "episode should be playing")
        
        episodeVM.stop()
        XCTAssert(!episodeVM.isPlaying , "episode should be set as played after play and stop")
        
    }
    
    
}
