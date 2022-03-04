//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Michael Ha on 3/3/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // MARK: layout
        let layoutGridMovie = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        // the space betwwen the row
        layoutGridMovie.minimumLineSpacing = 4
        layoutGridMovie.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layoutGridMovie.minimumInteritemSpacing * 2) / 3
        layoutGridMovie.itemSize = CGSize(width: width, height: width * 3 / 2)
    
        // MARK: URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    // print(dataDictionary)
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 
                 
                 // reload after the view show up 
                 self.collectionView.reloadData()
                 print(self.movies)
             }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieGridViewController: UICollectionViewDataSource {
    // Implement first method to return the number of items.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Implement second method to return the cell to be displayed
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        cell.posterView.af.setImage(withURL: posterURL!)
        
        
        return cell
    }
    
    
}

extension MovieGridViewController: UICollectionViewDelegate {

}
