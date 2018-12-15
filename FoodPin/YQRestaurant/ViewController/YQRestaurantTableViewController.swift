//
//  YQRestaurantTableViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import CoreData

class YQRestaurantTableViewController: UIViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var searchController: UISearchController!

    var fetchResultController: NSFetchedResultsController<RestaurantMO>!

    var restaurantView: YQRestaurantView?
    
    
    var restaurantOriginalArray: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend.jpg", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233423", description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "homei.jpg", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "354-243523", description: "Take a moment to stop and smell tealeaves! We are about the community, our environment, and all things created by the warmth of our hands. We open at 11 AM, and close at 7 PM. At teakha, we sell only the best single-origin teas sourced by our sister company Plantation directly from small tea plantations. The teas are then either cooked to perfection with milk in a pot or brewed.", image: "teakha.jpg", isVisited: false),
        Restaurant(name: "Cafe Loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "453-333423", description: "A great cafe in Austrian style. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. We also serve breakfast and light lunch. Come over to enjoy the elegant ambience and quality coffee..", image: "cafeloisl.jpg", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", description: "An upscale dining venue, features premium and seasonal imported oysters, and delicate yet creative modern European cuisines. Its oyster bar displays a full array of freshest oysters imported from all over the world including France, Australia, USA and Japan.", image: "petiteoyster.jpg", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Hong Kong", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222", description: "A great local cafe for breakfast and lunch! Located in a quiet area in Sheung Wan, we offer pork chop buns, HK french toast, and many more. We open from 7 AM to 4:30 PM.", image: "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", description: "A boutique bakery focusing on artisan breads and pastries paired with inspiration from Japan and Scandinavia. We are crazy about bread and excited to share our artisan bakes with you. We open at 10 every morning, and close at 7 PM.", image: "posatelier.jpg", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phone: "982-434343", description: "We make everything by hand with the best possible ingredients, from organic sourdoughs to pastries and cakes. A combination of great produce, good strong coffee, artisanal skill and hard work creates the honest, soulful, delectable bites that have made Bourke Street Bakery famous. Visit us at one of our many Sydney locations!", image: "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phone: "734-232323", description: "Haigh's Chocolates is Australia's oldest family owned chocolate maker. We have been making chocolate in Adelaide, South Australia since 1915 and we are committed to the art of premium chocolate making from the cocoa bean. Our chocolates are always presented to perfection in our own retail stores. Visit any one of them and you'll find chocolate tasting, gift wrapping and personalised attention are all part of the service.", image: "haighschocolate.jpg", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phone: "872-734343", description: "We offer an assortment of on-site baked goods and sandwiches. This place has always been a favourite among office workers. We open at 7 every morning including Sunday, and close at 4 PM. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "palominoespresso.jpg", isVisited: false),
        Restaurant(name: "Upstate", type: "Seafood", location: "95 1st Ave New York, NY 10003", phone: "343-233221", description: "The absolute best seafood place in town. The atmosphere here creates a very homey feeling. We open at 5 PM, and close at 10:30 PM. ", image: "upstate.jpg", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phone: "985-723623", description: "A young crowd populates this pork-focused American eatery in an older Williamsburg neighborhood. We open at 6PM, and close at 11 PM. If you enjoy a shared small plates dinner experience, come over and have a try.", image: "traif.jpg", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phone: "455-232345", description: "Classic Italian deli & butcher draws patrons with meat-filled submarine sandwiches. We use the freshest meats and veggies to create the perfect panini for you. We look forward to seeing you!", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phone: "434-232322", description: "Small shop, some seating, definitely something different! We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of waffles with choices of sweet & savory fillings. If you are gluten free and craving waffles, this is the place to go.", image: "wafflewolf.jpg", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Bistro", location: "18 Bedford Ave Brooklyn, NY 11222", phone: "343-234553", description: " Great food, cocktails, ambiance, service. Nothing beats having a warm dinner and a whiskey. We open at 8 every morning, and close at 1 AM. The ricotta pancakes are something you must try.", image: "fiveleaves.jpg", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phone: "342-455433", description: "Good place, great environment and amazing food! We open at 10 every morning except Sunday, and close at 9 PM. Give us a visit! Enjoy mushroom raviolis, pumpkin raviolis, meat raviolis with sausage and peppers, pork cutlets, eggplant parmesan, and salad.", image: "cafelore.jpg", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phone: "643-332323", description: "Most delicious cocktail you would ever try! Our menu includes a wide range of high quality internationally inspired dishes, vegetarian options, and local cuisine. We open at 10 AM, and close at 10 PM. We welcome you into our place to enjoy a meal with your friends.", image: "confessional.jpg", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phone: "542-343434", description: "a collection of authentic Spanish Tapas bars in Central London! We have an open kitchen, a beautiful marble-topped bar where guests can sit and watch the chefs at work and stylish red leather stools. Lunch starts at 1 PM. Dinners starts 5:30 PM.", image: "barrafina.jpg", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phone: "722-232323", description: "Very good basque food, creative dishes with terrific flavors! Donostia is a high end tapas restaurant with a friendly relaxed ambiance. Come over to enjoy awesome tapas!", image: "donostia.jpg", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", description: "Specialise in great pub food. Established in 1872, we have local and world lagers, craft beer and a selection of wine and spirits for people to enjoy. Don't forget to try our range of Young's Ales and Fish and Chips.", image: "royaloak.jpg", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phone: "432-344050", description: "With kitchen serving gourmet burgers. We offer food every day of the week, Monday through to Sunday. Join us every Sunday from 4:30 – 7:30pm for live acoustic music!", image: "caskpubkitchen.jpg", isVisited: false)
    ]
    
    var restaurantInfoArray: [RestaurantMO] = []
    
    var searchResults: [RestaurantMO] = []
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        
        if isLoadedData() {
            print("Data is loaded")
        } else {
            initData()
        }
        
        configNav()
        initSearchBar()
        initRestaurantView()
    }
    
    func initData() {
        for index in 0...restaurantOriginalArray.count - 1 {
            let restaurantOriginal = restaurantOriginalArray[index]
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let restaurantMO = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurantMO.name = restaurantOriginal.name
                restaurantMO.type = restaurantOriginal.type
                restaurantMO.location = restaurantOriginal.location
                restaurantMO.phone = restaurantOriginal.phone
                restaurantMO.summary = restaurantOriginal.description
                restaurantMO.rating = ""
                if let restaurantImage = UIImage(named: restaurantOriginal.name) {
                    let imageData = restaurantImage.pngData()
                    restaurantMO.image = imageData
                }
                restaurantMO.isVisited = restaurantOriginal.isVisited
                restaurantInfoArray.append(restaurantMO)
            }
            
        }
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            print("Saving data to context ...")
            appDelegate.saveContext()
        }
        
    }
    
    
    func isLoadedData() -> Bool {
        var isLoaded = false
        
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurantInfoArray = fetchedObjects
                }
                if restaurantInfoArray.count > 0 {
                    isLoaded = true
                    print("restaurant count is \(restaurantInfoArray.count)")
                }
            } catch {
                print(error)
            }
        }
        
        return isLoaded
    }
    
    func configNav() {
        navigationController?.navigationBar.topItem?.title = "Food Pin"
        
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
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(YQRestaurantTableViewController.onClickNavRightButton(recognizer:)))
        self.navigationItem.rightBarButtonItem = rightItem
        
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func initSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
        
    /// 显示状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func initRestaurantView() -> Void {
        restaurantView = YQRestaurantView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        restaurantView?.restaurantInfoArray = self.restaurantInfoArray
        self.view.addSubview(restaurantView!)
        
    }
    
    func filterContent(for searchText: String) {
        searchResults = restaurantInfoArray.filter({ (restaurant) -> Bool in
            if let name = restaurant.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
    //MARK: - 点击事件
    @objc func onClickNavRightButton(recognizer: UITapGestureRecognizer) {
        let NewRestaurantVC = YQNewRestaurantViewController()
        self.navigationController?.pushViewController(NewRestaurantVC, animated: true)
    }
    
    //MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        restaurantView?.mainTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        restaurantInfoArray = controller.fetchedObjects as! [RestaurantMO]
        restaurantView?.restaurantInfoArray = restaurantInfoArray
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                restaurantView?.mainTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                restaurantView?.mainTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                restaurantView?.mainTableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            restaurantView?.mainTableView.reloadData()
        }

    
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        restaurantView?.mainTableView.endUpdates()
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            restaurantView?.searchResults = searchResults
            restaurantView?.mainTableView.reloadData()

        }
    }

}

