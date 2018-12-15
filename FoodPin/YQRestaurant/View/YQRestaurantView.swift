//
//  YQRestaurantView.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import CoreData

class YQRestaurantView: UIView, UITableViewDelegate, UITableViewDataSource  {

    let cellIdentifier = "YQRestaurantCellTableViewCell"
    
    var restaurantInfoArray: [RestaurantMO]!
    var searchResults: [RestaurantMO]!
    
    var mainTableView: UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeMainTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化tableview
    func initializeMainTableView() -> Void {
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height), style: UITableView.Style.plain)
        mainTableView.backgroundColor = UIColor.white
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.register(YQRestaurantCellTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.addSubview(mainTableView)
        
    }
    
    // MARK: - tableViewDelegate & tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchControllerIsActive() {
            return searchResults.count
        } else {
            return restaurantInfoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: YQRestaurantCellTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! YQRestaurantCellTableViewCell)
        
        if indexPath.row < (searchControllerIsActive() ? searchResults.count : restaurantInfoArray.count) {
            cell.setData(restaurant: searchControllerIsActive() ? searchResults[indexPath.row] :  restaurantInfoArray[indexPath.row])
            
            let restaurant = searchControllerIsActive() ? searchResults[indexPath.row] : restaurantInfoArray[indexPath.row]
            if restaurant.isVisited {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let detailViewController = YQRestaurantDetailViewController.init(restaurant: searchControllerIsActive() ? searchResults[indexPath.row] : restaurantInfoArray[indexPath.row])
        
        if searchControllerIsActive() {
//            currentViewController()?.dismiss(animated: false, completion: nil)
        }
        currentNavigationController().pushViewController(detailViewController, animated: true)

    }
    
    // 向右滑cell
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkInAction = UIContextualAction(style: .normal, title: "Check In") { (action, soureView, comletionHandler) in
            let cell = tableView.cellForRow(at: indexPath)
            
            if indexPath.row < self.restaurantInfoArray.count {
                let restaurant = self.restaurantInfoArray[indexPath.row]
                if restaurant.isVisited {
                    cell?.accessoryType = .none
                    restaurant.isVisited = false
                } else {
                    cell?.accessoryType = .checkmark
                    restaurant.isVisited = true
                }
                
                tableView.reloadRows(at: [indexPath], with: .none)
            }


            comletionHandler(true)
        }
        
        if indexPath.row < self.restaurantInfoArray.count {
            let restaurant = self.restaurantInfoArray[indexPath.row]
            if restaurant.isVisited {
                checkInAction.image = UIImage(named: "undo")
            } else {
                checkInAction.image = UIImage(named: "tick")
            }
        }
        
        checkInAction.backgroundColor = UIColor.green
        
        let swipConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        return swipConfiguration
        
    }
    
    // 向左滑cell
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
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        // 用extionsion方法
        deleteAction.image = UIImage(named: "delete")
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, comletionHandler) in
            let restaurant = self.restaurantInfoArray[indexPath.row]
            
            let defaultText = "Just checking in at " + restaurant.name!
            let activityController: UIActivityViewController
            
            if let imageToShare = restaurant.image {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            
            self.currentViewController()?.present(activityController, animated: true, completion: nil)
            comletionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    // 搜索状态不准编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchControllerIsActive() {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Helper Method
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }

    func currentNavigationController() -> UINavigationController {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            return appDelegate.baseNavigationController
        }
        return UINavigationController()
    }
    
    func searchControllerIsActive() -> Bool {
        var searchIsActive = false
        if let currentVC = self.currentViewController() as? UISearchController {
            if currentVC.isActive {
                searchIsActive = true
            }
        }
        
        return searchIsActive
    }
    
    

}
