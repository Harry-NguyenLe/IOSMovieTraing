//
//  UIImageView.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 08/02/2022.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?){
        self.image = nil
        
        if let cacheImage = imageCache.object(forKey: NSString(string: URLString)){
            self.image = cacheImage
            return
        }
        
        if let url = URL(string: URLString){
            URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                if error != nil{
                    DispatchQueue.main.async { [weak self] in
                        self?.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data){
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self?.image = downloadedImage
                        }
                    }
                    
                }
            }).resume()
        }
    }
}
