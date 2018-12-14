//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/13.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
