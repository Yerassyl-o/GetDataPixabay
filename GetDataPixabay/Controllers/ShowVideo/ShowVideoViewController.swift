//
//  ShowVideoViewController.swift
//  GetDataPixabay
//
//  Created by Yerassyl Orazbekov on 03.12.2021.
//

import UIKit
import  WebKit

class ShowVideoViewController: UIInputViewController, WKUIDelegate {
    var websiteURL: String?
    var webView: WKWebView!
    
    override func loadView() {
        webViewSettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
    }
}

extension ShowVideoViewController {
    func webViewSettings() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    func loadUrl() {
        let myURL = URL(string: websiteURL ?? "https://google.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

    

