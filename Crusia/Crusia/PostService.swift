//
//  PostService.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 3..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostService {
    
    // MARK: - Properties
    static let shared: PostService = PostService()
    
    private init() {}

    
    
    func getRecentPost(start timestamp: Int? = nil, limit: Int, completionHandler: @escaping ([House]) -> Void) {
        
        Alamofire.request("http://crusia.xyz/apis/house/", method: .get).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                var allPost: [House] = []
                var newPosts: [House] = []
                
                let json = JSON(value)
                
                
                for (index,subJson):(String, JSON) in json {
                    
                    print(index)
                    
                    let temp: House = House(house: subJson)
                    
                    allPost.append(temp)
                }
                
                // Pk 순으로 sorting
                allPost.sort(by: { (first, second) -> Bool in
                    return first.pk.int! < second.pk.int!
                })
                
                
                
                if let latestPostTimestamp = timestamp, latestPostTimestamp > 0 {
                    
                    // timestamp 가 있을 경우, timestamp 보다 더 최신의 포스트들을 가져온다
                    if allPost.count >= limit {
                        
                        for _ in 0...limit - 1 {
                            
                            if (allPost.last?.pk.int)! > latestPostTimestamp {
                                newPosts.append(allPost.last!)
                                allPost.removeLast()
                            }
                        }
                        
                    } else {
                        
                        for _ in 0...allPost.count - 1 {
                            
                            if (allPost.last?.pk.int)! > latestPostTimestamp {
                                newPosts.append(allPost.last!)
                                allPost.removeLast()
                            }
                        }
                    }
                    
                    
                } else {
                    
                    // timestamp  없을 경우, 그냥 최신 포스트들을 가져온다.
                    if allPost.count >= limit {
                        
                        for _ in 0...limit - 1 {
                            
                            newPosts.append(allPost.last!)
                            allPost.removeLast()
                        }
                        
                    } else {
                        
                        for _ in 0...allPost.count - 1 {
                            newPosts.append(allPost.last!)
                            allPost.removeLast()
                        }
                    }
                }

                
                // print("JSON: \(newPost)")
                

                completionHandler(newPosts)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOldPosts(start timestamp: Int, limit: Int, completionHandler: @escaping ([House]) -> Void) {

        print("getOldPosts .................................")
        print("getOldPosts .................................")
        
        Alamofire.request("http://crusia.xyz/apis/house/", method: .get).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                print("Validation Successful")
                
                var allPost: [House] = []
                var postsLessthanTimeStamp: [House] = []
                var newPosts: [House] = []
                
                let json = JSON(value)
                
                for (index,subJson):(String, JSON) in json {
                    
                    print(index)
                    
                    let temp: House = House(house: subJson)
                    
                    allPost.append(temp)
                }
                
                // Pk 순으로 sorting
                allPost.sort(by: { (first, second) -> Bool in
                    return first.pk.int! > second.pk.int!
                })
                

                    
                for i in allPost {
                    
                    if i.pk.int! < timestamp {
                        postsLessthanTimeStamp.append(i)
                    }
                }
                
                
                for _ in 0...limit {
                    
                    if let firstPost = postsLessthanTimeStamp.first {
                        newPosts.append(firstPost)
                        postsLessthanTimeStamp.removeFirst()
                    }
                }
                
               
                
                
                print("new Posts ....................................................................................................")
                print(newPosts)
                completionHandler(newPosts)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}
