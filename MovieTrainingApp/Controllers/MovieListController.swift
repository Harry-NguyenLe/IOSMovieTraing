//
//  ViewController.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 25/01/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class MovieListController: UIViewController, UITableViewDelegate, MovieTableViewCellDelegate, UITableViewDataSource, LikeMovieDelegate, UnlikeMovieDelegate {

    @IBOutlet var tableView: UITableView!
    var dataSourceFromNetwork: [MovieData] = Array()
    var dataSourceFromLocal: [MovieDataStorage] = Array()
    var page: Int = 1
    let realm = try! Realm()
    var isLoading: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        getDataSourceFromNetwork(with: self.page)
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
                
        let item = dataSourceFromNetwork[indexPath.row]
        cell.movieTitleLabel.text = item.title
        cell.movieDescriptionLabel.text = item.overview
        cell.movieViewsNumberLabel.text = "Views number: " + item.popularity.description
        cell.moviePosterView.loadImageUsingCacheWithURLString(
            Constant.IMAGE_URL + item.posterPath,
            placeHolder: UIImage(named: "Account")
        )
        cell.movieData = item
        let movieDataStorage = MovieDataStorage()
        cell.movieDataStorage = movieDataStorage
        cell.movieDataStorage?.title = item.title
        cell.movieDataStorage?.overview = item.overview
        cell.movieDataStorage?.popularity = item.popularity
        
        getSetOnMovieLiked(cell: cell)
        cell.delegate = self
        cell.likeDelegate = self
        cell.unlikeDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return number of cell
        return dataSourceFromNetwork.count
    }
    
    private func getSetOnMovieLiked(cell: MovieCell){
        let dataSourceFromLocal = self.realm.objects(MovieDataStorage.self)
        if dataSourceFromLocal.count > 0 {
            for movie in dataSourceFromLocal {
                cell.updateFilmLiked(data: movie)
            }
        }
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Config the table view display
        cell.backgroundColor = UIColor.clear
        let lastElement = dataSourceFromNetwork.count - 1
        
        if indexPath.row == lastElement {
            self.perform(#selector(loadTable), with: nil, afterDelay: 1.0 )
        }

    }
    
    @objc func loadTable(){
        getDataSourceFromNetwork(with: self.page)
    }
    
    //MARK: - Get data from API
    private func getDataSourceFromNetwork(with page: Int){
        self.startLoading()
        let service = MovieListService()
        service.getRequest(with: self.page) {result in
            if result.count > 0{
                if self.dataSourceFromNetwork.count <= 0 {
                    self.dataSourceFromNetwork = result
                }else {
                    self.dataSourceFromNetwork.append(contentsOf: result)
                }
                self.page = page + 1
                self.tableView.reloadData()
                self.stopLoading()
                
            }else{
                self.showToast(message: "End of list reached", font: .systemFont(ofSize: 12.0))
                self.stopLoading()
            }
        }
        getDataSourceFromLocal()
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
    
    
    //MARK: - Add loading view
    
    func startLoading(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func stopLoading(){
        dismiss(animated: false, completion: nil)
    }
        
    //MARK: - Handle local data
    func likeMovieSet(movieData: MovieDataStorage) {
        
        let movieLiked = self.realm.objects(MovieDataStorage.self).filter("title='\(movieData.title)'").first
        if movieLiked == nil {
            try! self.realm.write {
                self.realm.add(movieData)
                
            }
        }
    }
    
    func unlikeMovieSet(movieData: MovieDataStorage) {
        
        let movieLiked = self.realm.objects(MovieDataStorage.self).filter("title='\(movieData.title)'").first
        
        if movieLiked != nil{
            try! self.realm.write{
                self.realm.delete(movieLiked!)
                
            }
        }
    }
    
    func getDataSourceFromLocal(){
        let dataSourceFromLocal = realm.objects(MovieDataStorage.self)
        self.dataSourceFromLocal.append(contentsOf: dataSourceFromLocal)
    }
}

