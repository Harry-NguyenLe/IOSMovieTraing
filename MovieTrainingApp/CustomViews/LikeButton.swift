//
//  LikeButton.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 09/02/2022.
//

import Foundation
import UIKit

class LikeButton: UIButton{
    
    
    var btn_id: Int = 0
    
    func toggle(isLike isLiked: Bool){
        if isLiked == true {
            self.setImage(UIImage(named: "ic_like_orange@3x.png"), for: .normal)
            self.setTitle("  Liked", for: .normal)
        }else{
            self.setImage(UIImage(named: "ic_like@3x.png"), for: .normal)
            self.setTitle("  Like", for: .normal)
        }
    }
}
