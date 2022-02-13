//
//  MovieDetailController.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 25/01/2022.
//

import Foundation
import UIKit

class MovieDetailController : UIViewController, UIGestureRecognizerDelegate {
    
    var movieData: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Init Configuration
    private func configNavigationBar(){
        let appColor = UIColor(red: 202/255, green: 92/255, blue: 39/255, alpha: 1.0)
        self.navigationController?.setStatusBar(
            backgroundColor: appColor
        )

        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.backgroundColor = appColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Thin", size: 16)!
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
        navigationItem.title = movieData?.title
    }

}
