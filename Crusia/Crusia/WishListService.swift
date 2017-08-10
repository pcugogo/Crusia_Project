//
//  WishListService.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation

class WishListService {
    
    static let shared: WishListService = WishListService()
    
    var houses: [House] = []
    
    private init() {}

    // 위시 리스트에 하우스 추가
    func add(house: House) {
        
        var houseInfo = house
        houseInfo.addedTowishList = false
        
        self.houses.append(houseInfo)
        
    }
    
    // 위시 리스트에서 하우스 삭제
    func delete(house: House) {
        
        for i in 0...houses.count - 1 {
            
            if houses[i].pk == house.pk {
                
                houses.remove(at: i)
                return
            }
        }
    }
    
    func getWishList(completionHandler: @escaping ([House]) -> Void) {
        
        var posts = houses
        // Pk 순으로 sorting
        posts.sort(by: { (first, second) -> Bool in
            return first.pk.int! < second.pk.int!
        })
        
        completionHandler(posts)
    }
    
}















