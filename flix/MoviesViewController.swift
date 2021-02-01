//
//  MoviesViewController.swift
//  flix
//
//  Created by Brendan Lee on 1/27/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!  // table view outlet
    
    var movies = [[String: Any]]() // array of dictionaries for movies

    override func viewDidLoad() {
        super.viewDidLoad()
        print("App Start")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //API START
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            //print(dataDictionary)
            
            self.movies = dataDictionary["results"] as! [[String:Any]]  // casting. Download the list of movies from the api and store it in self.movies list
            self.tableView.reloadData()
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
        //API END
    }
    
    // tableView Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count  // num movies -> row count
    }
    
    // tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //Get movie info
        let movie = movies[indexPath.row] // access movie
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        //Add into cell
        cell.titleLabel.text = title
        cell.synopLabel.text = synopsis
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterURL)
        
        return cell
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
