//
//  ViewController.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 25/01/2022.
//

import UIKit
import Alamofire

class MovieListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let dataSource = ["first", "second", "third", "fourth", "fifth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        getDataSource()
    }
    
    //MARK - Configuration
    private func configNavigationBar(){
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(
            CGFloat(-10),
            for: UIBarMetrics.default
        )
    }
    
    private func configTableView(){
        let bgImage = UIImage(named: "bg@3x.png")
        let imageView = UIImageView(image: bgImage)
        imageView.contentMode = .scaleToFill
        tableView.backgroundView = imageView
        
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
     
    //MARK - Setting tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movieTitleLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return number of cell
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    //MARK - Get data from API
    private func getDataSource(){
        AF.request("https://api.themoviedb.org/4/list/2?page=1&api_key=55ed3f19957a0b683168d1011d835a73").response { response in
            print(response)
        }
    }
}

