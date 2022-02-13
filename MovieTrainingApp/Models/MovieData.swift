//
//  Movie.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 08/02/2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

class MovieData: Object, Decodable  {
    @objc dynamic var posterPath: String
    @objc dynamic var title: String
    @objc dynamic var originalTitle: String
    @objc dynamic var popularity: Float
    @objc dynamic var overview: String
    
    private init(posterPath: String, title: String, originalTitle: String, popularity: Float, overview: String){
        self.posterPath = posterPath
        self.title = title
        self.originalTitle = originalTitle
        self.popularity = popularity
        self.overview = overview
    }
    
   static func buildFrom(jsonResponse: JSON) -> [MovieData] {
       var movieList = [MovieData]()
       let json: Array<JSON> = jsonResponse["results"].arrayValue
       
       for value in json {
           let posterPath = value["poster_path"].stringValue
           let title = value["title"].stringValue
           let originalTitle = value["original_title"].stringValue
           let popularity = value["popularity"].floatValue
           let overview = value["overview"].stringValue
           let movieData =  MovieData(
               posterPath: posterPath,
               title: title,
               originalTitle: originalTitle,
               popularity: popularity,
               overview: overview
           )
           movieList.append(movieData)
       }
       return movieList
    }
}
