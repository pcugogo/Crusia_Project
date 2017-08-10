//
//  WishList.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WishList {
    
    var houses: [House] = []
    
    init(house: House) {
        self.houses.append(house)
    }
    
}
