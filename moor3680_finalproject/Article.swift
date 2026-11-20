//
//  Article.swift
//  moor3680_a6
//
//  Created by Roger Moore on 2022-04-01.
//

import Foundation
import UIKit

class Article {
    
    var title: String
    var details: String
    var photo: UIImage
    var urlPath: String
    
    init(title: String, details: String, photo: UIImage, urlPath: String){
        self.title = title
        self.details = details
        self.photo = photo
        self.urlPath = urlPath
    }
    
    func getTitle()  -> String{
        return self.title
    }

    func getDetails()  -> String{
        return self.details
    }
    
    func getPhoto() -> UIImage {
        return self.photo
    }
    
    func getUrlPath()  -> String{
        return self.urlPath
    }
}// Person
