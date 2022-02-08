//
//  ViewController.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 25/01/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var dataSource: [MovieData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        getDataSource(with: 1)
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
        let item = dataSource![indexPath.row]
        cell.movieTitleLabel.text = item.title
        cell.movieDescriptionLabel.text = item.overview
        cell.movieViewsNumberLabel.text = item.popularity.description
        cell.moviePosterView.loadImageUsingCacheWithURLString(
            Constant.IMAGE_URL + item.posterPath,
            placeHolder: UIImage(named: "Account")
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return number of cell
        if self.dataSource != nil {
            return dataSource!.count
        }else {
            return 0
        }
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    //MARK - Get data from API
    private func getDataSource(with page: Int){
        let service = MovieListService()
        service.getRequest(with: page) {result in
            self.dataSource = result
            self.tableView.reloadData()
        }
    }
}

