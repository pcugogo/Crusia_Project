//
//  WishListService.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 9..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WishListService {
    
    static let shared: WishListService = WishListService()
    
    var houses: [House] = []
    var heartImages: [UIImage] = []
    var heartIndex: [Int] = []
    
    private init() {}

    // 위시 리스트에 하우스 추가
    func add(house: House) {
        
        self.houses.append(house)
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
    
    
    func addAndDeleteHouseToWishList(housePk: Int) {
        
        let token: String = UserDefaults.standard.object(forKey: "token") as! String
        let httpHeader: HTTPHeaders = ["Authorization": "Token " + token]
        
        Alamofire.request("http://crusia.xyz/apis/like/?house=\(housePk)", method: .post, headers: httpHeader).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                let json = JSON(value)
                print("메세지: \(json)")
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func requestWishList(completionHandler: @escaping ([House]) -> Void) {
        
        let token: String = UserDefaults.standard.object(forKey: "token") as! String
        let httpHeader: HTTPHeaders = ["Authorization": "Token " + token]
        
        print("현재 유저 토큰 !! .................................................")
        print(token)
        
        Alamofire.request("http://crusia.xyz/apis/like/", method: .get, headers: httpHeader).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                var allPost: [House] = []
                
                let json = JSON(value)
                
                for (index,subJson):(String, JSON) in json {
                    
                    print(index)
                    
                    let temp: House = House(house: subJson)
                    
                    allPost.append(temp)
                }
                
                self.heartIndex = []
                
                for i in allPost {
                    
                    if !self.heartIndex.contains(i.pk.numberValue as! Int) {
                        self.heartIndex.append(i.pk.numberValue as! Int)
                    }
                }
                
                self.houses = allPost
                
                completionHandler(allPost)
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
    func loadWishList() {
        
        let token: String = UserDefaults.standard.object(forKey: "token") as! String
        let httpHeader: HTTPHeaders = ["Authorization": "Token " + token]
        
        print("현재 유저 토큰 !! .................................................")
        print(token)
        
        Alamofire.request("http://crusia.xyz/apis/like/", method: .get, headers: httpHeader).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                var allPost: [House] = []
                
                let json = JSON(value)
                
                for (index,subJson):(String, JSON) in json {
                    
                    print(index)
                    
                    let temp: House = House(house: subJson)
                    
                    allPost.append(temp)
                }
                
                self.heartIndex = []

                for i in allPost {
                    
                    if !self.heartIndex.contains(i.pk.numberValue as! Int) {
                        self.heartIndex.append(i.pk.numberValue as! Int)
                    }
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
}















