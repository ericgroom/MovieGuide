//
//  ViewController.swift
//  Movie Guide
//
//  Created by Eric Groom on 10/24/16.
//  Copyright © 2016 Eric Groom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "movieCell"
    
    let apiKey = "98c2046d14dfc35855b29169f903a66e"
    
    var movies: [Movie]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.delegate = self
        tableView!.dataSource = self
        makeAPICall()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MovieCell
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 149 // forces the cell to use custom height
    }
    
    func makeAPICall() {
        Alamofire.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)").validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print("Connection to API successful!")
                self.movies = Movie.movies(array: (json["results"].arrayObject as! [NSDictionary]))
                self.tableView.reloadData()
            case .failure(let error):
                print("ERROR: Unable to hit the API with status code: \(error)")
                print("Got status message: \(error)")

            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let movieDetailController = segue.destination as! MovieDetailController
        
        movieDetailController.movie = movie
    }
}

// nice color #7851A9


    



