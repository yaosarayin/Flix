//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Yao on 10/2/20.
//  Copyright © 2020 Yao. All rights reserved.
//

import UIKit
import AlamofireImage


class MoviesGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    
    var movies = [[String : Any ]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoviesCollectionView.delegate = self
        MoviesCollectionView.dataSource = self
        
        let layout = MoviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 10
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2 ) / 3
        let height = width * 3 / 2
        layout.itemSize = CGSize(width : width, height: height)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.movies = dataDictionary["results"] as! [[String : Any]]
            
            self.MoviesCollectionView.reloadData()
           }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseURL = "https://image.tmdb.org/t/p/w780"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string : baseURL + posterPath)
        
        cell.posterView.af_setImage(withURL: posterURL!)
        return cell
    }
}
