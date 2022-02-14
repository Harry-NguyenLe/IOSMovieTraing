//
//  MovieDataStorage.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 14/02/2022.
//

import Foundation
import RealmSwift
import SwiftUI

class MovieDataStorage: Object {
    @objc dynamic var title = ""
    @objc dynamic var popularity: Float = 0
    @objc dynamic var overview = ""
    @objc dynamic var isLike = false
    
    override class func primaryKey() -> String? { return "title" }
}
