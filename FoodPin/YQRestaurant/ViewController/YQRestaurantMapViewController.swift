//
//  YQRestaurantMapViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/13.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import MapKit

class YQRestaurantMapViewController: UIViewController {
    
    var mapView: MKMapView!
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeView()
        configure()
    }
    

    func initializeView() {
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(mapView)
    }
    
    func configure() {
        let geoCoder = CLGeocoder()
        
        print(restaurant.location)
        
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                // Add annnotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }

}
