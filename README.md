## 纯Swift代码构建一个功能完善的APP


效果演示

iOS11之后，导航栏可以设置这样变大的效果。

在 ViewController 的 viewDidLoad() 方法中添加下面这行代码可以实现：

```swift
	// iOS11之后这个属性可以让导航栏往下滑动的时候title变大
    navigationController?.navigationBar.prefersLargeTitles = true
```

![](https://github.com/yoferzhang/blogImage/blob/master/2018120801.gif)

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

![](https://github.com/yoferzhang/blogImage/blob/master/2018121401.gif)

自定义 `annotationView`，实现 `MKMapViewDelegate`

```swift
    //MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "😋"
        annotationView?.markerTintColor = UIColor.orange
        
        return annotationView
    }
```


![](https://github.com/yoferzhang/blogImage/blob/master/2018121402.png)

```swift
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.showsCompass = true
```

![](https://github.com/yoferzhang/blogImage/blob/master/2018121403.png)

测试一些动画

![](https://github.com/yoferzhang/blogImage/blob/master/2018121404.gif)

代理回调，将选择的表情回调给详情页，展示在 `headerView` 的右下角

![](https://github.com/yoferzhang/blogImage/blob/master/2018121405.gif)


静态列表，`textField`使用

![](https://github.com/yoferzhang/blogImage/blob/master/2018121406.gif)

图片选择器

![](https://github.com/yoferzhang/blogImage/blob/master/2018121407.gif)

改用 `CoreData` 存储数据，并用 `NSFetchedResultsController` 监听；新建局部刷新首页 `tableview`

![](https://github.com/yoferzhang/blogImage/blob/master/2018121501.gif)

删除后，局部刷新首页 `tableview`

```swift
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, soureView, comletionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                
                if let currentVC = self.currentViewController() as? YQRestaurantTableViewController {
                    let restaurantToDelete = currentVC.fetchResultController.object(at: indexPath)
                    context.delete(restaurantToDelete)
                    
                    appDelegate.saveContext()
                }
                
            }
            
            comletionHandler(true)
        }
```

![](https://github.com/yoferzhang/blogImage/blob/master/2018121502.gif)


更新rating 表情，同样是数据库级别的更新，加 `appDelegate.saveContext()` 就可以

```swift
    //MARK: - YQRestaurantReviewViewControllerDelegate
    func onClickRateButtonInReviewVC(rate: RateModel) {
        restaurant.rating = rate.image
        refreshRatingImageView(rateImage: rate.image)
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate.saveContext()
        }
    }
```

![](https://github.com/yoferzhang/blogImage/blob/master/2018121503.gif)

添加搜索栏，支持name搜索，搜索状态时禁止左右滑动的编辑态

![](https://github.com/yoferzhang/blogImage/blob/master/2018121504.gif)

`tabBarController`

![](https://github.com/yoferzhang/blogImage/blob/master/2018121505.png)

About页面；使用元组；分别用 `WKWebView` 和 `SFSafariViewController` 打开web页面

![](https://github.com/yoferzhang/blogImage/blob/master/2018121506.gif)

使用iCloud，在 CloudKit Dashboard 中创建数据；原本是想上传图片，但 Dashboard 一上传那图片就 停止响应了，苹果这个做的有点坑==

![](https://github.com/yoferzhang/blogImage/blob/master/2018122001.png)

然后用 Convenience API:


```swift
    func fetchRecordsFromCloud() {
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)

        publicDatabase.perform(query, inZoneWith: nil) { (results, error) in
            if let error = error {
                print(error)
                return
            }

            if let results = results {
                print("Completed the download of Restaurant data")
                self.restaurants = results
                DispatchQueue.main.async(execute: {
                    self.discoverTableView.reloadData()
                })
            }
        }
    }
```

代码中拉取到的数据结构：

![](https://github.com/yoferzhang/blogImage/blob/master/2018122002.png)

改用 Operational API。因为 Convenience API 不能只请求携带某些字段，它会把所有数据都完整拉下来

```swift
    func fetchRecordsFromCloud() {
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name", "iamge"]
        queryOperation.queuePriority = .veryHigh
        queryOperation.resultsLimit = 50
        queryOperation.recordFetchedBlock = { (record) -> Void in
            self.restaurants.append(record)
        }
        
        queryOperation.queryCompletionBlock = { [unowned self] (cursor, error) -> Void in
            if let error = error {
                print("Failed to get data from iCloud -\(error.localizedDescription)")
                
                return
            }
            
            print("Successfully retrieve the data from iCloud")
            DispatchQueue.main.async(execute: {
                self.discoverTableView.reloadData()
            })
        }
        
        publicDatabase.add(queryOperation)
    }
```

使用 `UIActivityIndicatorView` 和 `UIRefreshControl`

![](https://github.com/yoferzhang/blogImage/blob/master/2018122003.gif)

