//
//  ViewController.swift
//  TestingProject
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        loadMovies()
    }
    
    private func loadMovies() {
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                print("There was an error getting data: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieSearch = try decoder.decode(MovieSearch.self, from: data)
                    let movies = movieSearch.results
                    self.movies = movies.filter{ $0.contentAdvisoryRating == "Unrated" }
                    print(self.movies.count)
                } catch {
                    print("There was an error decoding data: \(error.localizedDescription)")
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movie cell", for: indexPath)
        let movie = movies[indexPath.row]
        movieCell.imageView?.image = nil
        movieCell.textLabel?.text = movie.trackName
        movieCell.detailTextLabel?.text = movie.artistName
        MovieAPI.getMovieImageData(stringURL: movie.artworkUrl100) { (error, data) in
            if let error = error {
                print("There was an error getting data: \(error.localizedDescription)")
            } else if let data = data {
                DispatchQueue.main.async {
                    movieCell.imageView?.image = UIImage(data: data)
                    movieCell.setNeedsLayout()
                }
            }
        }
        return movieCell
    }
}

// Unrated  41
