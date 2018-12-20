//
//  YQRestaurantMapViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/13.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
private struct MapViewControllerConstants {
    static let leftMarginOfCloseButton: CGFloat = 20
    static let widthOfCloseButton: CGFloat = 22

}

import UIKit
import MapKit

class YQRestaurantMapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var closeButton: UIButton!
    
    var restaurant: RestaurantMO!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeView()
        configure()
    }
    

    func initializeView() {
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        mapView.delegate = self
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.showsCompass = true
        self.view.addSubview(mapView)
        
        closeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - MapViewControllerConstants.leftMarginOfCloseButton - MapViewControllerConstants.widthOfCloseButton, y: 30, width: MapViewControllerConstants.widthOfCloseButton, height: MapViewControllerConstants.widthOfCloseButton))
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.addTarget(self, action: #selector(onClickCloseButton), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    func configure() {
        let geoCoder = CLGeocoder()
        
        print(restaurant.location!)
        
        geoCoder.geocodeAddressString(restaurant.location!, completionHandler: {placemarks, error in
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
    
    //MARK: - 点击事件
    @objc func onClickCloseButton(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

}
