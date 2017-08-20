//
//  TextTransition.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 20..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import UIKit

enum OriginalText {
    case petAllwoed
    case eleavator
    case gym
    case indoorFireplace
    case internet
    case doorman
    case kitchen
    case pool
    case smokingAllowed
    case wheelchairAccessible
    case wirelessInternet
    case freeParking
    case breakfast
    case dryer
    case cableTV
    case hangers
    case washer
    case shampoo
    case essentials
    case heating
    case tv
    case airConditioning
    case house
    case individual
    case sharedRoom
}

extension OriginalText {
    
    var toString: String {
        switch self {
        case .petAllwoed:
            return "Pets_allowed"
        case .eleavator:
            return "Elevator"
        case .gym:
            return "Gym"
        case .indoorFireplace:
            return "Indoor_fireplace"
        case .internet:
            return "Internet"
        case .doorman:
            return "Doorman"
        case .kitchen:
            return "Kitchen"
        case .pool:
            return "Pool"
        case .smokingAllowed:
            return "Smoking_allowed"
        case .wheelchairAccessible:
            return "Wheelchair_accessible"
        case .wirelessInternet:
            return "Wireless_Internet"
        case .freeParking:
            return "Free_parking"
        case .breakfast:
            return "Breakfast"
        case .dryer:
            return "Dryer"
        case .cableTV:
            return "Cable_TV"
        case .hangers:
            return "Hangers"
        case .washer:
            return "Washer"
        case .shampoo:
            return "Shampoo"
        case .essentials:
            return "Essentials"
        case .heating:
            return "Heating"
        case .tv:
            return "TV"
        case .airConditioning:
            return "Air_conditioning"
        case .house:
            return "House"
        case .individual:
            return "Individual"
        case .sharedRoom:
            return "Shared_Room"
        }
    }
}

extension OriginalText {
    var description: String {
        switch self {
        case .petAllwoed:
            return "애완동물 허용"
        case .eleavator:
            return "엘레베이터"
        case .gym:
            return "헬스장"
        case .indoorFireplace:
            return "벽난로"
        case .internet:
            return "인터넷"
        case .doorman:
            return "도어맨"
        case .kitchen:
            return "부엌"
        case .pool:
            return "수영장"
        case .smokingAllowed:
            return "흡연 가능"
        case .wheelchairAccessible:
            return "휠체어 접근성"
        case .wirelessInternet:
            return "무선인터넷"
        case .freeParking:
            return "무료주차"
        case .breakfast:
            return "아침식사"
        case .dryer:
            return "헤어드라이어"
        case .cableTV:
            return "케이블 TV"
        case .hangers:
            return "옷걸이"
        case .washer:
            return "세탁기"
        case .shampoo:
            return "샴푸"
        case .essentials:
            return "생필품"
        case .heating:
            return "냔방"
        case .tv:
            return "TV"
        case .airConditioning:
            return "에어컨"
        case .house:
            return "집 전체"
        case .individual:
            return "개인실"
        case .sharedRoom:
            return "공용실"
        }
    }
}
