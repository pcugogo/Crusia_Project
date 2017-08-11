//
//  MapLocationViewController.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 5..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import MapKit

//class MyAnnotation: NSObject,MKAnnotation { //어노테이션즈는 핀이 여러개 찍힌다
//    
//    var coordinate: CLLocationCoordinate2D
//    var title:String?
//    var subtitle: String?
//    
//    init(coordinate:CLLocationCoordinate2D,title:String) {
//        self.title = title
//        self.coordinate = coordinate
//    }
//    
//}


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

    @IBOutlet weak var centerPinImg: UIImageView!
 
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
                    annotation.title = ""
                    annotation.subtitle = ""
                    
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        print("#############")
                        // Display the annotation
                        
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                        self.mapView.removeAnnotation(annotation)
                    }
                }
                
            })
        
        
       
        
//        if #available(iOS 9.0, *) {
//            mapView.showsCompass = true
//            mapView.showsScale = true
//            mapView.showsTraffic = true
//        }

       
       
            }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerPinImg.animationImages = [#imageLiteral(resourceName: "PinHostingPick"),#imageLiteral(resourceName: "PinHosting")]
        centerPinImg.animationDuration = 1
        centerPinImg.animationRepeatCount = 2
        centerPinImg.startAnimating()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        switch newState {
        case .starting:
            centerPinImg.image = #imageLiteral(resourceName: "PinHosting")
            view.dragState = .dragging
            
        case .ending, .canceling:
            centerPinImg.image = #imageLiteral(resourceName: "PinHostingPick")
            view.dragState = .none
        default: break
        }
    }
    
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "MyPin"
//        
//        if annotation.isKind(of: MKUserLocation.self) {
//            return nil
//        }
//        
//        // Reuse the annotation if possible
//        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
//        
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView?.canShowCallout = true
//        }
//        
//        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
//        leftIconView.image = UIImage(named: "CheckImg")
//        annotationView?.leftCalloutAccessoryView = leftIconView
//        
//        // Pin color customization
//        if #available(iOS 9.0, *) {
//            annotationView?.pinTintColor = UIColor.orange
//        }
//        
//        return annotationView
//    }
    
    // MARK: - Action methods
    


    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        HostingService.shared.latitude = mapView.centerCoordinate.latitude
        HostingService.shared.longitude = mapView.centerCoordinate.longitude
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
