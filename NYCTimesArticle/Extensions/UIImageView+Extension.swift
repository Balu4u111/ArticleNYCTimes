//
//  UIImageView+Extension.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 22/01/22.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView {
    
    func applyRoundedShape() {
        layer.cornerRadius = frame.width/2
        layer.masksToBounds = true
    }
    
    func setImageFor(urlString: String) {
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { [weak self]
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: response)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self?.image = imageToCache
                }
            }
        }.resume()
    }
}
