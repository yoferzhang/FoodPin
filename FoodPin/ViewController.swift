//
//  ViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var restaurantView: YQRestaurantView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // iOS11之后这个属性可以让导航栏往下滑动的时候title变大
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.initRestaurantView()

    }
        
    /// 显示状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func initRestaurantView() -> Void {
        restaurantView = YQRestaurantView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(restaurantView!)
        
    }


}

