//
//  ApiService.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 27/01/2022.
//

import Foundation
import Alamofire
import SwiftUI
import CoreData
import SwiftyJSON

class MovieListService: NSObject {
    
    public func getRequest(with page: Int, handleComplete: @escaping (_ result: [MovieData]) -> ()){
        let headers: HTTPHeaders = [
            "Content-Type":"application/json;charset=utf-8"
        ]
        let params: [String : Any] = [
            "page": page,
            "api_key": Constant.API_KEY
        ]
        
        AF.request(Constant.MOVIE_LIST,
                   method: .get,
                   parameters: params,
                   headers: headers)
            .responseDecodable(of: MovieData.self) {response in
                let responseData = try! JSON(data: response.data!)
                handleComplete(MovieData.buildFrom(jsonResponse: responseData))
        }
    }
}


