//
//  YQDiscoverViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/20.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import CloudKit

class YQDiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    private var imageCache = NSCache<CKRecord.ID, NSURL>()
    var restaurants: [CKRecord] = []
    var discoverTableView: UITableView!
    var spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        initViews()
        fetchRecordsFromCloud()
        initSpinner()
    }
    

    func configureNav() {
        navigationController?.navigationBar.topItem?.title = "Discover"
        
        navigationController?.navigationBar.tintColor = UIColor.orange
        
        // iOS11之后这个属性可以让导航栏往下滑动的时候title变大
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 去掉返回按钮的文字
        let leftItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = leftItem
        
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func initViews() {
        discoverTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        discoverTableView.separatorStyle = .singleLine
        discoverTableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        view.addSubview(discoverTableView)
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        discoverTableView.refreshControl = UIRefreshControl()
        discoverTableView.refreshControl?.backgroundColor = .white
        discoverTableView.refreshControl?.tintColor = .gray
        discoverTableView.refreshControl?.addTarget(self, action: #selector(fetchRecordsFromCloud), for: UIControl.Event.valueChanged)
    }
    
    func initSpinner() {
        spinner.style = .gray
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: 150)
        
        spinner.startAnimating()
    }
    
//    func fetchRecordsFromCloud() {
//        let cloudContainer = CKContainer.default()
//        let publicDatabase = cloudContainer.publicCloudDatabase
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
//
//        publicDatabase.perform(query, inZoneWith: nil) { (results, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//
//            if let results = results {
//                print("Completed the download of Restaurant data")
//                self.restaurants = results
//                DispatchQueue.main.async(execute: {
//                    self.discoverTableView.reloadData()
//                })
//            }
//        }
//    }
    
    @objc func fetchRecordsFromCloud() {
        restaurants.removeAll()
        discoverTableView.reloadData()
        
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
                self.spinner.stopAnimating()
                self.discoverTableView.reloadData()
                
                if let refreshControl = self.discoverTableView.refreshControl {
                    if refreshControl.isRefreshing {
                        refreshControl.endRefreshing()
                    }
                }
            })
            
        }
        
        publicDatabase.add(queryOperation)
    }
    
    
    // MARK: - tableViewDelegate & tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoverTableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        let restaurant = restaurants[indexPath.row]
        cell.textLabel?.text = restaurant.object(forKey: "name") as? String
        
        cell.imageView?.image = UIImage(named: "photo")
        
        if let iamgeFileURL = imageCache.object(forKey: restaurant.recordID) {
            print("Get image from cahce")
            if let iamgeData = try? Data.init(contentsOf: iamgeFileURL as URL) {
                cell.imageView?.image = UIImage(data: iamgeData)
            }
            
        } else {
            let publicDatabase = CKContainer.default().publicCloudDatabase
            let fetchRecordsImageOperation = CKFetchRecordsOperation(recordIDs: [restaurant.recordID])
            fetchRecordsImageOperation.desiredKeys = ["image"]
            fetchRecordsImageOperation.queuePriority = .veryHigh
            
            fetchRecordsImageOperation.perRecordCompletionBlock = {[unowned self] (record, recordID, error) -> Void in
                if let error = error {
                    print("Failed to get restaurant image: \(error.localizedDescription)")
                    return
                }
                
                if let restaurantRecord = record,
                    let image = restaurantRecord.object(forKey: "image"),
                    let imageAsset = image as? CKAsset {
                    
                    if let iamgeData = try? Data.init(contentsOf: imageAsset.fileURL) {
                        DispatchQueue.main.async {
                            cell.imageView?.image = UIImage(data: iamgeData)
                            cell.setNeedsLayout()
                        }
                        
                        self .imageCache.setObject(imageAsset.fileURL as NSURL, forKey: restaurant.recordID)
                    }
                }
            }
            
            publicDatabase.add(fetchRecordsImageOperation)
        }
        
       
        
        return cell
    }


}
