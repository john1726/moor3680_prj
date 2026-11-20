//
//  MedDetailViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-19.
//

import UIKit

class MedDetailViewController: UIViewController {

    var article:Article?
    @IBOutlet weak var medDetailNavigationBarItem: UINavigationItem!
    @IBOutlet weak var medDetailImageView: UIImageView!
    @IBOutlet weak var medDetailTextView: UITextView!
    let segueID = "WebView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medDetailImageView.image = self.article?.getPhoto()
        medDetailTextView.text = self.article?.getDetails()
        medDetailNavigationBarItem.title = self.article?.getTitle()
    }
    
    func initWithArticle(article: Article) {
        self.article = article
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
