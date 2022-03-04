//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Michael Ha on 3/3/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    var movie: [String: Any]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        posterView.af.setImage(withURL: posterURL!)
        
        let backDropPath = movie["backdrop_path"] as! String
        let backDropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backDropPath)
        backDropView.af_setImage(withURL: backDropURL!)
        
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