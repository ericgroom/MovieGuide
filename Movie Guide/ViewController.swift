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
import Realm
import RealmSwift
let apiKey = "98c2046d14dfc35855b29169f903a66e"

let realmObject = try! Realm()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "movieCell"
    
    var movies: [Movie]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.delegate = self
        tableView!.dataSource = self
        
        self.tableView.addSubview(self.refreshControl)
        
        //Realm db path: DEBUG
        print(Realm.Configuration.defaultConfiguration.description)
        
        let dbMovies = realmObject.objects(Movie.self)
        
        if dbMovies.count > 0 {
            print("Found movies in DB")
            var newMoviesArray = [Movie]()
            for movie in dbMovies {
                newMoviesArray.append(movie)
            }
            movies = newMoviesArray
        } else {
            //make API call and save data in the realm db
            makeAPICall()
        }
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        makeAPICall()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
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


    



