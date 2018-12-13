//
//  YQRestaurantDetailViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
private struct Constants {
    static let nameLabelX: CGFloat = 12
}

import UIKit

class YQRestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var restaurant: Restaurant!
    
    var detailTableView: UITableView!
    var headerView: UIImageView!
    var headerMaskView: UIView!
    var nameLabel: UILabel!
    var typeLabel: UILabel!
    var heartImageView: UIImageView!
    
    init(restaurant: Restaurant) {
        super.init(nibName: nil, bundle: nil)
        self.restaurant = restaurant
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // Do any additional setup after loading the view.
        initializeDetailTableView()
        
    }
    
    func initializeDetailTableView() {
        detailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.register(YQRestaurantDetailIconTextCell.self, forCellReuseIdentifier: String(describing: YQRestaurantDetailIconTextCell.self))
        detailTableView.register(YQReataurantDetailTextCell.self, forCellReuseIdentifier: String(describing: YQReataurantDetailTextCell.self))
        
        detailTableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(detailTableView)
        
        self.initializeHeaderView()
    }
    
    func initializeHeaderView() {
        headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 350))
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: restaurant.name)
        headerView.layer.masksToBounds = true
        
        headerMaskView = UIView(frame: headerView.bounds)
        headerMaskView.backgroundColor = UIColor.black
        headerMaskView.alpha = 0.2
        headerView.addSubview(headerMaskView)
        
        
        typeLabel = UILabel(frame: CGRect.zero)
        typeLabel.font = UIFont.systemFont(ofSize: 13)
        typeLabel.text = restaurant.type
        typeLabel.textColor = UIColor.white
        typeLabel.layer.cornerRadius = 5.0
        typeLabel.layer.masksToBounds = true
        typeLabel.textAlignment = .center
        typeLabel.sizeToFit()
        typeLabel.backgroundColor = UIColor.orange
        typeLabel.frame = CGRect(x: Constants.nameLabelX, y: headerView.frame.height - 15 - typeLabel.frame.height, width: typeLabel.frame.width + 10, height: typeLabel.frame.height)
        headerView.addSubview(typeLabel)
        
        heartImageView = UIImageView(frame: CGRect(x: typeLabel.frame.maxX + 6, y: 0, width: 15, height: 15))
        heartImageView.image = UIImage(named: "heart-tick")
        heartImageView.center = CGPoint(x: heartImageView.center.x, y: typeLabel.center.y)
        headerView.addSubview(heartImageView)
        if restaurant.isVisited {
            heartImageView.isHidden = false
        } else {
            heartImageView.isHidden = true
        }
        
        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 35)
        nameLabel.text = restaurant.name
        nameLabel.textColor = UIColor.white
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: Constants.nameLabelX, y: typeLabel.frame.origin.y - 6 - nameLabel.frame.height, width: headerView.frame.width - Constants.nameLabelX - Constants.nameLabelX, height: nameLabel.frame.height)
        headerView.addSubview(nameLabel)
        
        
        detailTableView.tableHeaderView = headerView
    }
    
    // MARK: - tableViewDelegate & tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantDetailIconTextCell.self), for: indexPath) as! YQRestaurantDetailIconTextCell
            cell .setData(imageName: "phone", detailText: restaurant.phone)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantDetailIconTextCell.self), for: indexPath) as! YQRestaurantDetailIconTextCell
            cell .setData(imageName: "map", detailText: restaurant.location)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQReataurantDetailTextCell.self), for: indexPath) as! YQReataurantDetailTextCell
            cell .setData(detailText: restaurant.description)
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 50
        case 2:
            return 300
        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }
    }
    
}
