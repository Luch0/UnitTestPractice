//
//  MovieAPITests.swift
//  TestingProjectTests
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import XCTest
@testable import TestingProject

class MovieAPiTests: XCTestCase {
    
    func testMovieAPI() {
        let exp = expectation(description: "movie results received")
        //var movieCount = 0
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let search = try decoder.decode(MovieSearch.self, from: data)
                    let _ = search.results.count
                    exp.fulfill()
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
        // assync
        wait(for: [exp], timeout: 10.0)
        //XCTAssertGreaterThan(movieCount, 11, "movie count should be greater than 0")
    }
    
    func testMovieExist() {
        let exp = expectation(description: "movie results received")
        var search: MovieSearch!
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    search = try decoder.decode(MovieSearch.self, from: data)
                    
                    // fulfill to indicate task is complete
                    exp.fulfill()
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
        // async call so we need to wait until the expectation is fulfilled
        wait(for: [exp], timeout: 3.0)
        
        XCTAssertEqual(search.results[0].trackName, "Blue Collar Comedy Tour: One for the Road", "movie does not exist")
    }
    
    
    func testMovieAPIForUnrated() {
        let exp = expectation(description: "movie results received")
        var unratedMovieCount = 0
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let search = try decoder.decode(MovieSearch.self, from: data)
                    let movies = search.results
                    unratedMovieCount = movies.filter{ $0.contentAdvisoryRating == "Unrated" }.count
                    exp.fulfill()
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
        // assync
        wait(for: [exp], timeout: 10.0)
        XCTAssertEqual(unratedMovieCount,41, "unrated movie count should be 41")
    }
    
    
}
