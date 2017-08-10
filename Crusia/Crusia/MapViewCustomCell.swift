//
//  MapViewCustomCell.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 7..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit
import MapKit

class MapViewCustomCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(house: House) {
        
    
        if let lat = house.latitude.double, let long = house.longitude.double {
            
            let location = CLLocation(latitude: lat, longitude: long)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 350.0, 350.0)
            
            mapView.setRegion(coordinateRegion, animated: true)
            
            let pin = MKPointAnnotation()
            pin.title = "숙소 위치"
            pin.coordinate = location.coordinate
            
            mapView.addAnnotation(pin)
            
            mapView.showAnnotations([pin], animated: true)
            mapView.selectAnnotation(pin, animated: true)
            
        }
        
    }
    

}

