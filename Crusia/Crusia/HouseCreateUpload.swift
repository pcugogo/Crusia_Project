//
//  HouseCreateUpload.swift
//  Crusia
//
//  Created by 샤인 on 2017. 8. 17..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HouseCreateUpload {
    static var standard = HouseCreateUpload()
    var parameters: Parameters = HostingService.shared.houseParameters()
    
    func houseCreateUpload() {
    
    
            print(parameters)
            let httpHeader:HTTPHeaders = ["Authorization":"Token \(HostingService.shared.header)"]
            let url = "http://crusia.xyz/apis/house/"
            // 이미지 파일 수정
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                let image = HostingService.shared.houseImages
    
                for key in self.parameters.keys{
                    let name = String(key)
                    if let val = self.parameters[name!] as? String{
                        print(val)
                        multipartFormData.append(val.data(using: .utf8)!, withName: name!)
    
                    }
                }
                for key in self.parameters.keys{
                    let name = String(key)
                    if let val = self.parameters[name!] as? Int{
                        print(val)
                        multipartFormData.append("\(val)".data(using: .utf8)!, withName: name!)
    
                    }
                }
                for key in self.parameters.keys{
                    let name = String(key)
                    if let val = self.parameters[name!] as? Double{
                        print(val)
                        multipartFormData.append("\(val)".data(using: .utf8)!, withName: name!)
    
                    }
                }
    
    
                if !(image.isEmpty) {
                    for i in 0...image.count - 1{
                        print(i)
                        if image.count == 1 {
                            multipartFormData.append(image[i], withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                        }else{
                            multipartFormData.append(image[i], withName: "image\(i)", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                        }
    
                    }
                }
    
            }, usingThreshold:UInt64.init(),
               to: url, //URL Here
                method: .post,
                headers: httpHeader,
                encodingCompletion: { (result) in
    
                    switch result {
                    case .success(let upload, _, _):
                        print("success ......................................................")
    
                        upload.uploadProgress(closure: { (progress) in
                            print("something")
                        })
    
                        upload.responseJSON { response in
                            print("the resopnse code is : \(String(describing: response.response?.statusCode))")
                            print("the response is : \(response)")
                            
//                            DispatchQueue.main.async {
//                                HostingService.shared.resetData()
//                            }
                        }
                        break
                    case .failure(let encodingError):
                        print("the error is  : \(encodingError.localizedDescription)")
                        break
                    }
            })
            
            
        }
}
