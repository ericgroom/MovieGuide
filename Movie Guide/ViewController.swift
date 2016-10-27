//
//  ViewController.swift
//  Movie Guide
//
//  Created by Eric Groom on 10/24/16.
//  Copyright © 2016 Eric Groom. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "movieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.delegate = self
        tableView!.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MovieCell
        cell.titleLabel.text = "Suicide Squad"
        cell.posterImage.image = UIImage(named: "Martian")
        print(cell.titleLabel.text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 149
    }

    

}

