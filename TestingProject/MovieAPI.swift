//
//  MovieAPI.swift
//  TestingProject
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct MovieAPI {
    static let urlSession = URLSession(configuration: .default)
    static let urlRequest = URLRequest(url: URL(string: "https://itunes.apple.com/search?media=movie&term=comedy&limit=100")!)
    static func searchMovies(keyword: String, completion: @escaping (Error?, Data?) -> Void) {
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                //print("Movies error - \(error.localizedDescription)")
                completion(error,nil)
            } else if let data = data {
                //print(data)
                completion(nil,data)
            }
            }.resume()
    }
    static func getMovieImageData(stringURL: String, completion: @escaping (Error?, Data?) -> Void) {
        let urlRequestImage = URLRequest(url: URL(string: stringURL)!)
        urlSession.dataTask(with: urlRequestImage) { (data, response, error) in
            if let error = error {
                //print("Movies error - \(error.localizedDescription)")
                completion(error,nil)
            } else if let data = data {
                //print(data)
                completion(nil,data)
            }
            }.resume()
    }
}
