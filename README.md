Swift练习demo


效果演示

![](https://github.com/yoferzhang/blogImage/blob/master/2018120801.gif)

iOS11之后，导航栏可以设置这样变大的效果。

在 ViewController 的 viewDidLoad() 方法中添加下面这行代码可以实现：

```swift
	// iOS11之后这个属性可以让导航栏往下滑动的时候title变大
    navigationController?.navigationBar.prefersLargeTitles = true
```

向右滑动菜单：

![](https://github.com/yoferzhang/blogImage/blob/master/2018120802.gif)

向左滑动菜单：

![](https://github.com/yoferzhang/blogImage/blob/master/2018120803.gif)

tableView，actionSheet

![](https://github.com/yoferzhang/blogImage/blob/master/2018120804.gif)

详情页面

![](https://github.com/yoferzhang/blogImage/blob/master/2018121301.gif)

导航栏透明，并修改大字体状态的title颜色， `viewDidLoad()`中

```swift
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    
    // 设置导航栏title的大字体状态的颜色
    if let customFont = UIFont(name: "PingFangSC-Medium", size: 40.0) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
    }
```

详情页面的导航栏变透明，返回按钮变色

```swift
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
```

调整tableView的顶部位置

```swift
        detailTableView.contentInsetAdjustmentBehavior = .never
```

![](https://github.com/yoferzhang/blogImage/blob/master/2018121302.gif)

全局修改导航栏的返回按钮 `application(_:didFinishLaunchingWithOptions:)` 中添加

```swift
        let backButtonImage = UIImage(named: "back")
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
```

![](https://github.com/yoferzhang/blogImage/blob/master/2018121303.png)

修改详情页状态栏，

```swift
    /// 状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
```

可以没有生效，因为会用导航栏controller的颜色，为了让可以针对性修改页面，加一个Extension文件，`UINavigationController+Ext.swift`

```swift
import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

```

![](https://github.com/yoferzhang/blogImage/blob/master/2018121304.png)

添加地图信息
