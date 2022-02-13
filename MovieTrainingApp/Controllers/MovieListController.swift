//
//  ViewController.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 25/01/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieListController: UIViewController, UITableViewDelegate, MovieTableViewCellDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var dataSource: [MovieData] = Array()
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        getDataSource(with: self.page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    private func configNavigationBar(){
        let appColor = UIColor(red: 202/255, green: 92/255, blue: 39/255, alpha: 1.0)
        self.navigationController?.setStatusBar(
            backgroundColor: appColor
        )

        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.backgroundColor = appColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Thin", size: 18)!
        ]
        navigationItem.title = "HFILM"
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
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
     
    //MARK: - Setting tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
                
        let item = dataSource[indexPath.row]
        cell.movieTitleLabel.text = item.title
        cell.movieDescriptionLabel.text = item.overview
        cell.movieViewsNumberLabel.text = "Views number: " + item.popularity.description
        cell.moviePosterView.loadImageUsingCacheWithURLString(
            Constant.IMAGE_URL + item.posterPath,
            placeHolder: UIImage(named: "Account")
        )
        cell.movieData = item
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return number of cell
        return dataSource.count
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Config the table view display
        cell.backgroundColor = UIColor.clear
        let lastElement = dataSource.count - 1
        
        if indexPath.row == lastElement {
            self.perform(#selector(loadTable), with: nil, afterDelay: 1.0 )
        }

    }
    
    @objc func loadTable(){
        self.getDataSource(with: self.page)
    }
    
    //MARK: - Get data from API
    private func getDataSource(with page: Int){
        let service = MovieListService()
        service.getRequest(with: self.page) {result in
            if result.count > 0{
                if self.dataSource.count <= 0 {
                    self.dataSource = result
                }else {
                    self.dataSource.append(contentsOf: result)
                }
                self.page = page + 1
                self.tableView.reloadData()
            }else{
                self.showToast(message: "End of list reached", font: .systemFont(ofSize: 12.0))
            }
        }
    }
    
    
    //MARK: - Perform click on watch movie btn
    func watchMovieBtnClick(subcribeButtonTappedFor movieData: MovieData) {
        goToMovieDetailScreen(movieData: movieData)
    }
    
    //MARK: - Screen Navigation
    func goToMovieDetailScreen(movieData: MovieData){
        let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailController") as? MovieDetailController
        movieDetailVC?.movieData = movieData
        navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
}

