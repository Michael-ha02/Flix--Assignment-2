//
//  ViewController.swift
//  Flix
//
//  Created by Michael Ha on 2/21/22.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController {
    
    
    // step 1: add UITableViewDelegate and UITableViewDataSource
    @IBOutlet weak var tabelView: UITableView!
    // create an array of dictionary
    var movies = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // step 3: set delegate and dataSource = self
        tabelView.delegate = self
        tabelView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                 self.tabelView.reloadData()
             }
        }
        task.resume()
    }
    
    // MARK: Navigation
    // In a story board-based application, you will often want to do a little preparation navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // Get the new view controller using segue.destination
        // Passed the selected object to the new view controller
        
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tabelView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        // deselect the view after we complete
        tabelView.deselectRow(at: indexPath, animated: true)
    }
}

// step 2: implement 2 function
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // return number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueResuableCell: if another cell off the screen, give the recycle cell. And if there is no recyle cell, give me new one
        let cell = tabelView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.synopisLabel.text = synopsis
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        cell.posterView.af.setImage(withURL: posterURL!)
        
        return cell
    }
}
