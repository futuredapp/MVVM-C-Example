//
//  MVVMTestProjectTests.swift
//  MVVMTestProjectTests
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import XCTest
import PromiseKit

let mockupSeasons = [Season(name: "blah", episodes: [Episode(name: "episode1"), Episode(name: "episode2"), Episode(name: "episode3")])]

class Test1SeasonServices: SeasonsServices {
    internal func update(episode: Episode, name: String?) -> Promise<Episode> {
        return Promise { fulfill, reject in
            fulfill(episode)
        }
    }

    func create(episode: Episode, inSeason season: Season) -> Promise<Episode> {
        return Promise { fulfill, reject in
            season.episodes.append(episode)
            fulfill(episode)
        }
    }

    func seasons() -> Promise<[Season]> {
        return Promise { fulfill, reject in

            fulfill(mockupSeasons)
        }

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
        _ = vm.load().then { _ -> Void in
            XCTAssert(vm.numberOfSeasons() == 1, "season 1 is missing")

            XCTAssert(vm.seasonForIndexPath(IndexPath(row: 0, section: 0)).title.value == "blah", "season 1 has wrong name")

            XCTAssert(vm.seasonForIndexPath(IndexPath(row: 0, section: 0)).numberOfEpisodes() == mockupSeasons[0].episodes.count, "season has wrong number of episodes")
        }


    }
    

    func getEpisode() -> Promise<EpisodeDetailViewModel> {
        let vm  = SeasonsTableViewModel(seasonsServices: services)
        return vm.load().then { _ -> EpisodeDetailViewModel in
            let indexPath = IndexPath(row: 0, section: 0)
            return vm.seasonForIndexPath(indexPath).getEpisode(indexPath)
        }


    }
    
    func testGetEpisode() {
        
        _ = getEpisode().then { (episodeViewModel) -> Void in
             XCTAssert(episodeViewModel.title.value == "episode1" , "s01e01 is missing")
        }

    }
    
    func testPlayEpisode() {

        _ = getEpisode().then { (episodeViewModel) -> Void in
            episodeViewModel.play()
            XCTAssert(episodeViewModel.isPlaying.value, "should be playing")

        }

    }
    
    func testEpisodeWasPlayed() {


        _ = getEpisode().then { (episodeViewModel) -> Void in
            XCTAssert(!episodeViewModel.played, "should not be played")

            episodeViewModel.play()
            XCTAssert(episodeViewModel.played, "should be played")

        }


        
    }
 
    func testPlayAndStopEpisode() {

        _ = getEpisode().then { (episodeViewModel) -> Void in

            episodeViewModel.play()
             XCTAssert(episodeViewModel.isPlaying.value, "episode should be playing")

            episodeViewModel.stop()
            XCTAssert(!episodeViewModel.isPlaying.value, "episode should be set as played after play and stop")
            
        }

    }

    func testAddEpisodeWithInvalidName() {

        let except = expectation(description: "expectation")

        let viewModel = EpisodeCreateViewModel(season: mockupSeasons[0], seasonService: services)
        viewModel.name = ""

        viewModel.save().then {
            XCTFail("episode was created")
        }.catch { err in
            if case EpisodeCreateViewModel.EpisodeCreate.WrongName = err {
                except.fulfill()
                return
            }
            XCTFail("wrong error code")
        }

        waitForExpectations(timeout: 5, handler: nil)

    }
    
}
