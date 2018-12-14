//
//  UIColor+Ext.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/13.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
