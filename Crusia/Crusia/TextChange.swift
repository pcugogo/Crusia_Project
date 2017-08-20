//
//  TextChange.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import UIKit

class TextChange {
    
    static let shared: TextChange = TextChange()
    
    func enter(text: String) -> String {
        
        switch text {
        case OriginalText.petAllwoed.toString:
            return OriginalText.petAllwoed.description
        case OriginalText.eleavator.toString:
            return OriginalText.eleavator.description
        case OriginalText.gym.toString:
            return OriginalText.gym.description
        case OriginalText.indoorFireplace.toString:
            return OriginalText.indoorFireplace.description
        case OriginalText.internet.toString:
            return OriginalText.internet.description
        case OriginalText.doorman.toString:
            return OriginalText.doorman.description
        case OriginalText.kitchen.toString:
            return OriginalText.kitchen.description
        case OriginalText.pool.toString:
            return OriginalText.pool.description
        case OriginalText.smokingAllowed.toString:
            return OriginalText.smokingAllowed.description
        case OriginalText.wheelchairAccessible.toString:
            return OriginalText.wheelchairAccessible.description
        case OriginalText.wirelessInternet.toString:
            return OriginalText.wirelessInternet.description
        case OriginalText.freeParking.toString:
            return OriginalText.freeParking.description
        case OriginalText.breakfast.toString:
            return OriginalText.breakfast.description
        case OriginalText.dryer.toString:
            return OriginalText.dryer.description
        case OriginalText.cableTV.toString:
            return OriginalText.cableTV.description
        case OriginalText.hangers.toString:
            return OriginalText.hangers.description
        case OriginalText.washer.toString:
            return OriginalText.washer.description
        case OriginalText.shampoo.toString:
            return OriginalText.shampoo.description
        case OriginalText.essentials.toString:
            return OriginalText.essentials.description
        case OriginalText.heating.toString:
            return OriginalText.heating.description
        case OriginalText.tv.toString:
            return OriginalText.tv.description
        case OriginalText.airConditioning.toString:
            return OriginalText.airConditioning.description
        case OriginalText.house.toString:
            return OriginalText.house.description
        case OriginalText.individual.toString:
            return OriginalText.individual.description
        case OriginalText.sharedRoom.toString:
            return OriginalText.sharedRoom.description
        default:
            return ""
        }
    }
}
