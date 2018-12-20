//
//  YQRestaurantAboutController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/15.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import SafariServices

class YQRestaurantAboutController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var aboutTableView: UITableView!

    var sectionTitles = [NSLocalizedString("Feedback", comment: "feedback"), NSLocalizedString("Follow Us", comment: "Follow Us")]
    var sectionContent = [[(image: "store", text: NSLocalizedString("Rate us on App Store", comment: "Rate us on App Store"), link: "https://www.apple.com/itunes/charts/paid-apps/"),
                           (image: "chat", text: NSLocalizedString("Tell us your feedback on my blog", comment: "Tell us your feedback on my blog") , link: "http://yoferzhang.com/")],
                           [(image: "twitter", text: NSLocalizedString("Twitter", comment: "Twitter") , link: "https://twitter.com/LuciferZhangyq"),
                           (image: "facebook", text: NSLocalizedString("Fackbook", comment: "Fackbook") , link: "https://www.facebook.com/luciferzhang"),
                           (image: "instagram", text: NSLocalizedString("Instagram", comment: "Instagram") , link: "https://www.instagram.com/yoferzhang/"),]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
        configureNav()
    }
    

    func initViews() {
        aboutTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        aboutTableView.delegate = self
        aboutTableView.dataSource = self
        aboutTableView.separatorStyle = .singleLine
        aboutTableView.register(YQRestaurantDetailIconTextCell.self, forCellReuseIdentifier: String(describing: YQRestaurantDetailIconTextCell.self))
        
        view.addSubview(aboutTableView)
        
        initTableViewHeaderView()
    }
    
    func initTableViewHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
        
        let imageView = UIImageView(image: UIImage(named: "foodpin-logo"))
        imageView.sizeToFit()
        imageView.center = CGPoint(x: headerView.frame.width * 0.5, y: headerView.frame.height * 0.5)
        headerView.addSubview(imageView)
        
        aboutTableView.tableHeaderView = headerView
        
    }
    
    func configureNav() {
        navigationController?.navigationBar.topItem?.title = "About"
        
        navigationController?.navigationBar.tintColor = UIColor.orange
        
        // iOS11之后这个属性可以让导航栏往下滑动的时候title变大
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 设置导航栏title的大字体状态的颜色
        if let customFont = UIFont(name: "PingFangSC-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: customFont]
        }
        
        // 去掉返回按钮的文字
        let leftItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = leftItem
        
        navigationController?.hidesBarsOnSwipe = false
    }
    
    // MARK: - tableViewDelegate & tableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantDetailIconTextCell.self), for: indexPath) as! YQRestaurantDetailIconTextCell
        cell.selectionStyle = .none
        let cellData = sectionContent[indexPath.section][indexPath.row]
        cell.setData(imageName: cellData.image, detailText: cellData.text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellData = sectionContent[indexPath.section][indexPath.row]
        return YQRestaurantDetailIconTextCell.heightForIconTextCell(image: cellData.image, text: cellData.text)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let link = sectionContent[indexPath.section][indexPath.row].link
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else if indexPath.row == 1 {
                if link.count > 0 {
                    let webVC = YQWebViewController()
                    webVC.targetURL = link
                    self.navigationController?.pushViewController(webVC, animated: true)
                }
            }
        case 1:
            if let url = URL(string: link) {
                let safariController = SFSafariViewController(url: url)
                self.navigationController?.pushViewController(safariController, animated: true)
            }
        default:
            break
        }
    }

}
