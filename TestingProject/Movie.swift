//
//  Movie.swift
//  TestingProject
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct MovieSearch: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let trackName: String
    let artistName: String
    let contentAdvisoryRating: String
    let artworkUrl100: String
}
