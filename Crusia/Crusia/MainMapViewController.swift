//
//  MainMapViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 16..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import GoogleMaps

class MainMapViewController: UIViewController {

    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: viewForMap.bounds, camera: camera)
        viewForMap.addSubview(mapView)
        
        mapView.settings.myLocationButton = true
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 37.515364, longitude: 127.096749)
        marker2.title = "우리집"
        marker2.snippet = "잠실"
        marker2.map = mapView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}
