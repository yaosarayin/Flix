//
//  MoviesViewController.swift
//  Flix
//
//  Created by Yao on 9/19/20.
//  Copyright © 2020 Yao. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var MoviesTableView: UITableView!
    
    var movies = [[String : Any ]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.movies = dataDictionary["results"] as! [[String : Any]]
            
            self.MoviesTableView.reloadData()
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.nameLabel?.text = movie["title"] as? String
        //print("\(String(describing: movie["vote_average"]))")
        cell.voteLabel?.text = "\(movie["vote_average"]!)"
        cell.summaryLabel?.text = movie["overview"] as? String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string : baseURL + posterPath)
        
        cell.posterImage.af_setImage(withURL: posterURL!)
        return cell
    }
    
    override func prepare(for segue:
        UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
        // Pass the selected object to the new view controller
        
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = self.MoviesTableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // Pass selected movie to details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        self.MoviesTableView.deselectRow(at: indexPath, animated: true)
    }


}
