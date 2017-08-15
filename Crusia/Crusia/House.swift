//
//  House.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 3..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import SwiftyJSON

struct House {
    
    var pk: JSON
    var host: User
    var title: JSON
    var createDate: JSON
    var modifiedDate: JSON
    var address: JSON
    var introduce: JSON
    var spaceInfo: JSON
    var guestAccess: JSON
    var pricePerDay: JSON
    var extraPeopleFee: JSON
    var cleaningFee: JSON
    var weeklyDiscount: JSON
    var accommodates: JSON
    var bathrooms: JSON
    var bedrooms: JSON
    var beds: JSON
    var roomType: JSON
    var houseImages: JSON
    var amenities: JSON
    var latitude: JSON
    var longitude: JSON
    var wished: Bool = false
    
    init(house: JSON) {
        
        self.pk = house["pk"]
        self.host = User(user: house["host"])
        self.title = house["title"]
        self.createDate = house["create_date"]
        self.modifiedDate = house["modified_date"]
        self.address = house["address"]
        self.introduce = house["introduce"]
        self.spaceInfo = house["space_info"]
        self.guestAccess = house["guest_access"]
        self.pricePerDay = house["price_per_day"]
        self.extraPeopleFee = house["extra_people_fee"]
        self.cleaningFee = house["cleaning_fee"]
        self.weeklyDiscount = house["weekly_discount"]
        self.accommodates = house["accommodates"]
        self.bathrooms = house["bathrooms"]
        self.bedrooms = house["bedrooms"]
        self.beds = house["beds"]
        self.roomType = house["room_type"]
        self.houseImages = house["house_images"]
        self.amenities = house["amenities"]
        self.latitude = house["latitude"]
        self.longitude = house["longitude"]
    }
    
}


