//
//  CustomImageView.swift
//  VxTube
//
//  Created by shaik mulla syed on 8/2/17.
//  Copyright © 2017 shaik mulla syed. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {

    var ImageUrl : String?
    
    func downloadImagefromUrl(urlstring: String){
        image = nil
        ImageUrl = urlstring
        let url = URL(string: urlstring)
        if let cachedImage = imageCache.object(forKey: NSString(string: urlstring)) as? UIImage{
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error in downloading image",error!)
            }
            if let data = data{
                DispatchQueue.main.async {
                    let receivedImage = UIImage(data: data)
                    if self.ImageUrl == urlstring{
                        self.image = receivedImage
                    }
                    imageCache.setObject(receivedImage!, forKey: NSString(string: urlstring))
                }
            }
        }.resume()
    }

}
