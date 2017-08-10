//
//  MapViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var house: House!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("여기는 맵뷰!   ...................................................................................")
        
//        if let lat = house.latitude.double, let long = house.longitude.double {
//            
//            let location = CLLocation(latitude: lat, longitude: long)
//            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 350.0, 350.0)
//            
//            mapView.setRegion(coordinateRegion, animated: true)
//            
//            let annotation  = MKPointAnnotation()
//            annotation.title = "위치"
//            annotation.coordinate = location.coordinate
//            
////            mapView.addAnnotation(annotation)
//            
//            mapView.showAnnotations([annotation], animated: true)
//            mapView.selectAnnotation(annotation, animated: true)
//            
//        }
        

        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        
        
        
        geoCoder.geocodeAddressString(house.address.stringValue, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.house.title.string
                annotation.subtitle = self.house.host.email.string
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
        
        
        mapView.delegate = self

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        
        // 이미지 설정
        if let url = house.houseImages[0]["image"].url {

            leftIconView.kf.setImage(with: url)
        }
        
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }
}

