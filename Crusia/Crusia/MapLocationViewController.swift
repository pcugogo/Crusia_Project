//
//  MapLocationViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject,MKAnnotation { //어노테이션즈는 핀이 여러개 찍힌다
    
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle: String?
    
    init(coordinate:CLLocationCoordinate2D,title:String) {
        self.title = title
        self.coordinate = coordinate
    }
    
}


class MapLocationViewController: UIViewController,MKMapViewDelegate {

//    let manager = CLLocationManager()
    var address = ""
    var currentRoute:MKRoute?
    
    let locationManager = CLLocationManager()
    var currentPlacemark:CLPlacemark?
    
    var currentTransportType = MKDirectionsTransportType.automobile
    @IBOutlet weak var mapView: MKMapView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        mapView.delegate = self
//        // Do any additional setup after loading the view.
//    }

 
    var check = false
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
            print("true@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            let geoCoder = CLGeocoder()
            
            geoCoder.geocodeAddressString(address, completionHandler: { placemarks, error in
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@", self.address)
                if let error = error {
                    print(error)
                    return
                }
                print("!!!!!!!!!!!!!!!!!!!!!!!!!")
                if let placemarks = placemarks {
                    // Get the first placemark
                    let placemark = placemarks[0]
                    
                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = "패캠"
                    annotation.subtitle = "학원"
                    
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        print("#############")
                        // Display the annotation
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
                
            })
        
        
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
            mapView.showsScale = true
            mapView.showsTraffic = true
        }

       
       
            }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        leftIconView.image = UIImage(named: "CheckImg")
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        // Pin color customization
        if #available(iOS 9.0, *) {
            annotationView?.pinTintColor = UIColor.orange
        }
        
        return annotationView
    }
    
    // MARK: - Action methods
    
    @IBAction func showDirection(sender: AnyObject) {
        
//        switch segmentedControl.selectedSegmentIndex {
//        case 0: currentTransportType = MKDirectionsTransportType.automobile
//        case 1: currentTransportType = MKDirectionsTransportType.walking
//        default: break
//        }
        
//        segmentedControl.isHidden = false
        
        guard let currentPlacemark = currentPlacemark else {
            return
        }
        
        let directionRequest = MKDirectionsRequest()
        
        // Set the source and destination of the route
        directionRequest.source = MKMapItem.forCurrentLocation()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = currentTransportType
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (routeResponse, routeError) -> Void in
            
            guard let routeResponse = routeResponse else {
                if let routeError = routeError {
                    print("Error: \(routeError)")
                }
                
                return
            }
            
            let route = routeResponse.routes[0]
            self.currentRoute = route
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = (currentTransportType == .automobile) ? UIColor.blue : UIColor.orange
        renderer.lineWidth = 3.0
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        performSegue(withIdentifier: "showSteps", sender: view)
    }

    
    
    @IBAction func backBtnItem(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
