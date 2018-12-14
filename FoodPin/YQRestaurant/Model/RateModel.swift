//
//  RateModel.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/14.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import Foundation

class RateModel {
    var title: String
    var image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
    
    convenience init() {
        self.init(title: "", image: "")
    }
}
