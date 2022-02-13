//
//  BaseResponse.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 11/02/2022.
//

import Foundation

class BaseResponse<T> {
    
    var responseList: [T]?
    var page: Int?
    var totalPages: Int?
    
    init(responseList: [T], page: Int, totalPages: Int){
        self.responseList = responseList
        self.page = page
        self.totalPages = totalPages
    }
}
