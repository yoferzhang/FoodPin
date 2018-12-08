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
