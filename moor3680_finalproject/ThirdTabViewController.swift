//
//  ThirdTabViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-16.
//

import UIKit

class MedTableViewCell:UITableViewCell {
    
}

class ThirdTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, URLSessionTaskDelegate, XMLParserDelegate {
    let simpleTableIdentifier = "med-cell-identifier"
    var tableData = [Article]()
    var articleCounter: Int = 0
    var dataStore = NSData();
    let urlPath: String = "https://globalnews.ca/health/feed/"
    var currentElement = ""
    var currentLink = ""
    var processingElement = false
    var processingLink = false
    let ELEMENT_NAME = "description"
    var imageLink = ""
    var itemLink = ""
    let segueID = "MedDetailView"
    @IBOutlet weak var articleTableView: UITableView!
    
    //Mark: table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView tableData.count = \(self.tableData.count)")
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: segueID,
                     sender: self.tableData[indexPath.row])
        SharingCollection.sharedCollection.articleCollection.setCurrentIndex(to: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView(...) SharingCollection.sharedCollection.articleCollection.articles.count = \(SharingCollection.sharedCollection.articleCollection.articles.count)")
        
        // here, we try to r        e-use a cell, for efficiency
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: simpleTableIdentifier)
        }
        
        cell?.imageView?.image = self.tableData[indexPath.row].getPhoto()
        cell?.textLabel?.text = self.tableData[indexPath.row].getTitle()
        return cell!
    }
    
    //MARK: Prepare for  segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       if segue.identifier == segueID {
                
          //segue to the detail (destination) VC
          let detailVC = segue.destination as! MedDetailViewController;

            //invoke the function in the destination VC to pass data
          detailVC.initWithArticle(article: sender as! Article)
        } //
    }//  prepare for segue
    
    func createData() {
        print("createData() SharingCollection.sharedCollection.articleCollection.articles.count = \(SharingCollection.sharedCollection.articleCollection.articles.count)")
        
        for article in SharingCollection.sharedCollection.articleCollection.articles {
            print("createData() article.title = " + article.title)
            self.tableData.append(article)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1
        //spinner.startAnimating()
        //2
        // Don't need to add DispatchQueue.global here since it is in viewDidLoad which means it is already part of global queue
        //DispatchQueue.global(qos: .userInteractive).sync { [weak self] in
            //do {
                //let urlContents = try Data(contentsOf: (self?.imageURL)!)

                //self?.imageView.image = UIImage(data: urlContents)
                //self?.spinner.stopAnimating()
                //UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                let url: NSURL = NSURL(string: self.urlPath)!
                let request: URLRequest = URLRequest(url: url as URL)
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let task = session.dataTask(with: request, completionHandler:{ (data, response, error) in
                    self.dataStore = data! as NSData
                    let results = NSString(data: self.dataStore as Data, encoding: String.Encoding.utf8.rawValue)
                    print(" the xml file content is ")
                    print(results!)
                    print("the response is ")
                    print(response!)
                    print("articleCounter = " + String(self.articleCounter))
                    print("")
                    self.articleCounter += 1
                        
                    DispatchQueue.main.async { // must handle UI methods in the main thread
                        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    self.parseXML()
                })
                task.resume()
            //} catch {
            //    print("error: \(error)")
            //}
            //createData()
        //self.articleTableView.reloadData()
        //}//DispatchQueue
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - XML parsing
   
   func parseXML() {
       print("start the parser")
       let parser = XMLParser(data: dataStore as Data)
       parser.delegate = self;      // don't forget to set the delegate for the parser
       parser.parse()
   }
   
   func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
       print("func parser(_ parser: XMLParser, didStartElement elementName ...): get element " + currentElement)
       print("elementName = \(elementName)")
       print("attributesDict = \(attributeDict)")
       
       switch elementName {
       case "link":
           processingLink = true // we are processing the "link" element
       case ELEMENT_NAME:
           processingElement = true // we are processing the "description" element
       case "entry":
           print("entry")
           //itemLink = attributeDict["link"]! // get the link to the article
           //print("didStartElement: itemLink = \(itemLink)")
       case "item":
           print("item")
           //itemLink = attributeDict["link"]! // get the link to the article
           //print("didStartElement: itemLink = \(itemLink)")
       case "enclosure":
           imageLink = attributeDict["url"]! // get the link to the image
           print("didStartElement: imageLink = \(imageLink)")
       default:
           print("didStartElement no action")
       }
   }
   
   func parser(_ parser: XMLParser, foundCharacters string: String) {
       if processingElement {
           currentElement += string
           print("func parser(_ parser: XMLParser, foundCharacters string: String) currentElement = \(currentElement)")
       }
       
       if processingLink {
           //if currentLink.contains("https://") {
           //    currentLink = ""
           //}
           currentLink += string
           print("func parser(_ parser: XMLParser, foundCharacters string: String) currentLink = \(currentLink)")
       }
   }
   
   func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
       if elementName == "link" {
           print("elementName == link, currentElement = \(currentElement), currentLink = \(currentLink)")
           //var articleImage = UIImage(named: "delon.jpg")
           
           //if imageLink != "" && currentElement != "" {
           //    let imageURL = URL(string: imageLink)
           //    do {
           //        let urlContents = try Data(contentsOf: (imageURL)!)
           //        //3: to do UI stuffs, we need to get the main queue
           //        DispatchQueue.main.sync {
           //             articleImage = UIImage(data: urlContents)!
           //        }
                
           //        let article1 = Article(title: currentElement, details: currentElement, photo: articleImage!, urlPath: currentLink)
           //        SharingCollection.sharedCollection.articleCollection.articles.append(article1)
           //        print("parser(...) SharingCollection.sharedCollection.articleCollection.articles.count = \(SharingCollection.sharedCollection.articleCollection.articles.count)")
           //        self.tableData.append(article1)
           //    } catch {
           //        print("error: \(error)")
           //    }
           //} else if currentElement != "" {
           //    let article1 = Article(title: currentElement, details: currentElement, photo: articleImage!, urlPath: currentLink)
           //    SharingCollection.sharedCollection.articleCollection.articles.append(article1)
           //    print("parser(...) SharingCollection.sharedCollection.articleCollection.articles.count = \(SharingCollection.sharedCollection.articleCollection.articles.count)")
           //    self.tableData.append(article1)
           //}
           DispatchQueue.main.async(execute: { self.articleTableView.reloadData()})
           processingLink = false
           //currentLink = ""
       }
       
       if elementName == ELEMENT_NAME {
           print("elementName == ELEMENT_NAME, currentElement = \(currentElement), currentLink = \(currentLink)")
           print("func parser(_ parser: XMLParser, didEndElement elementName ...): get element " + currentElement)
           print("didEndElement: currentElement = \(currentElement)")
           print("didEndElement: imageLink = \(imageLink)")
           print("")
           var articleImage = UIImage(named: "delon.jpg")
           
           if imageLink != "" && currentElement != "" {
               let imageURL = URL(string: imageLink)
               do {
                   let urlContents = try Data(contentsOf: (imageURL)!)
                   //3: to do UI stuffs, we need to get the main queue
                   DispatchQueue.main.sync {
                        articleImage = UIImage(data: urlContents)!
                   }
                
                   let article1 = Article(title: currentElement, details: currentElement, photo: articleImage!, urlPath: currentLink)
                   SharingCollection.sharedCollection.articleCollection.articles.append(article1)
                   print("parser(...) SharingCollection.sharedCollection.articleCollection.articles.count = \(SharingCollection.sharedCollection.articleCollection.articles.count)")
                   self.tableData.append(article1)
               } catch {
                   print("error: \(error)")
               }
           } else if currentElement != "" {
               let article1 = Article(title: currentElement, details: currentElement, photo: articleImage!, urlPath: currentLink)
               SharingCollection.sharedCollection.articleCollection.articles.append(article1)
               print("parser(...) SharingCollection.sharedCollection.articleCollection.articles.count = \(SharingCollection.sharedCollection.articleCollection.articles.count)")
               self.tableData.append(article1)
           }
           DispatchQueue.main.async(execute: { self.articleTableView.reloadData()})
           processingElement = false
           currentElement = ""
           currentLink = ""
           //processingLink = false
           //currentLink = ""
       }
   } // didEndElement
   
   func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
       print("parser error " + String(describing: parseError))
   }
    
    // MARK
    // Navigation
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue){
        
    }
}
