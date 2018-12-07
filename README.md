Swift练习demo


效果演示

![](http://wx3.sinaimg.cn/large/a9c4d5f6gy1fxy7cy46o8g20gw0u0b2k.gif)

iOS11之后，导航栏可以设置这样变大的效果。

在 ViewController 的 viewDidLoad() 方法中添加下面这行代码可以实现：

```swift
	// iOS11之后这个属性可以让导航栏往下滑动的时候title变大
    navigationController?.navigationBar.prefersLargeTitles = true
```

向右滑动菜单：

![](http://wx2.sinaimg.cn/large/a9c4d5f6gy1fxy7k04rq5g20gw0u07wr.gif)

向左滑动菜单：

![](http://wx3.sinaimg.cn/large/a9c4d5f6gy1fxy7naz4dkg20gw0u0x6w.gif)

tableView，actionSheet

![](http://wx3.sinaimg.cn/large/a9c4d5f6gy1fxy7os4lafg20gw0u07wq.gif)
