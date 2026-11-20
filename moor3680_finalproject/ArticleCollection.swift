//
//  ArticleCollection.swift
//  moor3680_a6
//
//  Created by Roger Moore on 2022-04-02.
//

import Foundation
import UIKit

class ArticleCollection: NSObject, NSCoding, XMLParserDelegate {
    var articles = [Article]()
    var current:Int = 0 // the current article on the collection
    let collectionKey = "collectionKey"
    let indexKey = "indexKey"
    
    override init() {
        super.init()
        initCollection()
    }
    
    func initCollection(){
 
        
        
    }
    
    func article()->Article{
        let currentCard = articles[current]
        return currentCard
    }
    
    func setCurrentIndex(to index: Int) { // you may need this function for
        // relaunching the app
        current = index
    }
    
    // other helper functions you may need when relaunching the app
    // return the index of the current card in the deck
    func getCurrentIndex() -> Int {
        return current
    }// getCurrentIndex
    
    func encode(with coder: NSCoder) {
        coder.encode(articles, forKey: collectionKey)
        coder.encode(current, forKey: indexKey)
    }
    
    required init?(coder: NSCoder) {
        //articles = (coder.decodeObject(forKey: collectionKey) as? [articles])!
        current = (coder.decodeInteger(forKey: indexKey))
    }
}

