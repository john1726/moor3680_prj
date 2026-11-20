//
//  FourthTabViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-16.
//

import UIKit
import WebKit

class FourthTabViewController: UIViewController, WKNavigationDelegate {
    let kHEADERHEIGHT : CGFloat = 44.0
    //let kHEADERHEIGHT : CGFloat = 0.0 // set it to 44.0 if you want a header
    let kFOOTERHEIGHT : CGFloat = 44.0
    
    var webView : WKWebView = WKWebView()
    var headerView : UIView = UIView()
    var footerView : UIView = UIView()
    
    var leftArrowButton = UIButton(type: UIButton.ButtonType.custom)
    var rightArrowButton = UIButton(type: UIButton.ButtonType.custom)
    var listButton = UIButton(type: UIButton.ButtonType.custom)
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.allowsBackForwardNavigationGestures = true
        self.view.backgroundColor = UIColor.white
        self.headerView.backgroundColor = UIColor.gray
        self.footerView.backgroundColor = UIColor.gray
        
        // Image set
        self.leftArrowButton.setImage(UIImage(named: "left-arrow"), for: [])
        // when user presses on the left arrow button, the method back is executed
        self.leftArrowButton.addTarget(self, action:#selector(back(_ : )), for: .touchUpInside)
        
        self.rightArrowButton.setImage(UIImage(named: "right-arrow"), for: [])
        self.rightArrowButton.addTarget(self, action:#selector(forward(_ : )), for: .touchUpInside)
        
        self.listButton.setTitle("History", for: [])
        self.listButton.setTitleColor(UIColor.blue, for: [])
        
        self.listButton.addTarget(self, action: #selector(history(_:)), for: .touchUpInside)
        
        self.view.addSubview(self.headerView) // we do not need the header for this example
        self.view.addSubview(self.webView)
        self.view.addSubview(self.footerView)
        self.view.addSubview(self.leftArrowButton)
        self.view.addSubview(self.rightArrowButton)
        self.view.addSubview(self.listButton)
        
        patient = PatientCollection.collection[PatientCollection.getCurrentIndex()]
        let appendUrlAddress = patient?.getAddress().replacingOccurrences(of: " ", with: "%20")
        //let appendUrlAddress = patient?.getAddress()
        self.webView.navigationDelegate = self
        let urlPath = "https://mapquest.com/search/result?query=" + appendUrlAddress!
        let mapURL = URL(string: urlPath)
        self.webView.load(URLRequest(url: mapURL!))
        //self.webView.goForward()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        self.headerView.frame = CGRect(origin: CGPoint(x:0, y:statusBarHeight), size: CGSize(width: self.view.frame.size.width, height: kHEADERHEIGHT))
        
        self.webView.frame = CGRect(origin: CGPoint(x:0, y:statusBarHeight+kHEADERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - (statusBarHeight+kHEADERHEIGHT) - kFOOTERHEIGHT))
        
        self.footerView.frame = CGRect(origin: CGPoint(x:0, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: kFOOTERHEIGHT))
        
        self.leftArrowButton.frame = CGRect(origin: CGPoint(x:5, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
        
        
        self.rightArrowButton.frame = CGRect(origin: CGPoint(x:10 + kFOOTERHEIGHT, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
        
        self.listButton.frame = CGRect(origin: CGPoint(x:self.view.frame.size.width - 85, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: 80, height: kFOOTERHEIGHT))
    }
       
    // MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("Start")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NSLog("Failed Navigation %@", error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Finish navigation
        print("Finish Navigation")
        print("Title:%@ URL:%@", webView.title!, webView.url!)
    }
    
    // MARK: UI Event
    @objc func history(_ sender: Any) {
        let list : WKBackForwardList = self.webView.backForwardList
        
        if (list.backItem != nil) {
            print("Back %@", list.backItem!.url)
        }
        if (list.forwardItem != nil) {
            print("Forward %@",  list.forwardItem!.url)
        }
    } //history
    
    @objc func back(_ sender: Any) {
        if (self.webView.canGoBack) {
            self.webView.goBack()
        }
    } // back
    
    @objc func forward(_ sender: Any) {
        if (self.webView.canGoForward) {
            self.webView.goForward()
        }
    } // forward
}

