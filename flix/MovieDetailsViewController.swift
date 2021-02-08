//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Brendan Lee on 2/7/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // text
        titleLabel.text = (movie["title"] as! String)
        titleLabel.sizeToFit()
        synopLabel.text = (movie["overview"] as! String)
        synopLabel.sizeToFit()
        
        // poster image
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)!
        
        posterView.af_setImage(withURL: posterURL)
        
        // backdrop
        let backDropPath = movie["poster_path"] as! String
        let backDropURL = URL(string: "https://image.tmdb.org/t/p/w780" +  backDropPath)!
        
        backdrop.af_setImage(withURL: backDropURL)
    }
    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // sender: the cell that sent the user there
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("loading up details")
        // 1. Find selected movie (how do we know which one was chosen)
        let cell = sender as UItableviewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.cell]
        
        // 2. Pass the selected movie to the view
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
    }
 */
 
}
