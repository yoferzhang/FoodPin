//
//  YQRestaurantView.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit

class YQRestaurantView: UIView, UITableViewDelegate, UITableViewDataSource  {

    let cellIdentifier = "YQRestaurantCellTableViewCell"
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    var mainTableView: UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeMainTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeMainTableView() -> Void {
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height), style: UITableView.Style.plain)
        mainTableView.backgroundColor = UIColor.gray
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.register(YQRestaurantCellTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.addSubview(mainTableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: YQRestaurantCellTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! YQRestaurantCellTableViewCell)
        
        cell.setData(name: restaurantNames[indexPath.row], location: restaurantLocations[indexPath.row], type: restaurantTypes[indexPath.row], imageName: restaurantNames[indexPath.row])
        
        if restaurantIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//
//        let callActionHandler = { (action:UIAlertAction!) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.currentViewController()?.present(alertMessage, animated: true, completion: nil)
//
//        }
//
//        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
//        optionMenu.addAction(callAction)
//
//        let checkInAction = UIAlertAction(title: "Check In", style: .default, handler: {
//            (action:UIAlertAction!) -> Void in
//
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .checkmark
//
//            self.restaurantIsVisited[indexPath.row] = true
//        })
//        optionMenu.addAction(checkInAction)
//
//        self.currentViewController()?.present(optionMenu, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let detailViewController = YQRestaurantDetailViewController.init()
        detailViewController.restaurantImageName = restaurantNames[indexPath.row]
        detailViewController.restaurantName = restaurantNames[indexPath.row]
        detailViewController.restaurantLocation = restaurantLocations[indexPath.row]
        detailViewController.restaurantType = restaurantTypes[indexPath.row]
        
        currentViewController()?.show(detailViewController, sender: nil)
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            restaurantNames.remove(at: indexPath.row)
//            restaurantLocations.remove(at: indexPath.row)
//            restaurantTypes.remove(at: indexPath.row)
//            restaurantIsVisited.remove(at: indexPath.row)
//            
//            tableView.reloadData()
//        }
//    }
    
    // 向右滑cell
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkInAction = UIContextualAction(style: .normal, title: "Check In") { (action, soureView, comletionHandler) in
            let cell = tableView.cellForRow(at: indexPath)
            
            if self.restaurantIsVisited[indexPath.row] {
                cell?.accessoryType = .none
                self.restaurantIsVisited[indexPath.row] = false
            } else {
                cell?.accessoryType = .checkmark
                self.restaurantIsVisited[indexPath.row] = true
            }
            
            tableView.reloadRows(at: [indexPath], with: .none)

            comletionHandler(true)
        }
        
        if self.restaurantIsVisited[indexPath.row] {
            checkInAction.image = UIImage(named: "undo")
        } else {
            checkInAction.image = UIImage(named: "tick")
        }
        
        checkInAction.backgroundColor = UIColor.green
        
        let swipConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        return swipConfiguration
        
    }
    
    // 向左滑cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, soureView, comletionHandler) in
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            comletionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, comletionHandler) in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurantNames[indexPath.row]) {
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
    
    

}
