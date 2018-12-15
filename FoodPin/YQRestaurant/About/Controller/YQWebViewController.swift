//
//  YQWebViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/15.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import WebKit

class YQWebViewController: UIViewController {

    var webView: WKWebView!
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        // Do any additional setup after loading the view.
    }
    
    func initViews() {
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(webView)
        
        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func configureNav() {
        navigationItem.largeTitleDisplayMode = .never
    }

}
