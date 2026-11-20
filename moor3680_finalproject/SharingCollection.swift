//
//  SharingCollection.swift
//  moor3680_a6
//
//  Created by Roger Moore on 2022-04-02.
//

import Foundation

class SharingCollection {
    static let sharedCollection = SharingCollection()
    let filename = "articles.archive"
    private let rootKey = "rootKey"
    var articleCollection = ArticleCollection()
    
    func loadDeck() {
        print("Called loadDeck()")
    }
}
