//
//  WebVC.swift
//  ZotMeal
//
//  Created by Shengyuan Lu on 1/30/21.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var name:String = "ZotMeal: An error has occured with this search."
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let embedUrl = Constants.googleSearchURL + processName(name: name)
        
        // Load it into the webview
        let url = URL(string: embedUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func processName(name:String) -> String {
        var str = ""
        let postStr = removeSpecialCharsFromString(text: name)
        let strArray = postStr.split(separator: " ")
        
        print(strArray)
        
        for item in strArray {
            str.append(contentsOf: item)
            str.append("+")
        }
        
        let string = str.dropLast()
        
        return String(string)
    }
    

    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return text.filter {okayChars.contains($0) }
    }

}
