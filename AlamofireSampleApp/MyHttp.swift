//
//  myHttp.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/08.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyHttp {
    private static let urlServer = "http://192.168.3.10:3000"
    private static let urlList = "/api/db/list"
    private static let urlInsert = "/api/db/insert"
    private static let urlDelete = "/api/db/delete"
    private static let urlCount = "/api/db/count"
    
    //Count
    static func requestCount(closureCompletion: ((Bool, Data?) -> Void)?) {
        let countUrl = "\(urlServer)\(urlCount)"
        
        //GET
        Alamofire
            .request(countUrl)
            .responseJSON { resData in
                //エラーなら終了
                if resData.error != nil {
                    closureCompletion?(false, nil)
                    return
                }
                
                guard let response = resData.response else {
                    closureCompletion?(false, nil)
                    return
                }
                
                if response.statusCode != 200 {
                    closureCompletion?(false, nil)
                    return
                }
                
                guard let resultsData = resData.data else {
                    closureCompletion?(false, nil)
                    return
                }
                closureCompletion?(true, resultsData)
        }
    }
    
    //List
    static func requestList(closureCompletion: ((Bool, Data?) -> Void)?) {
        let listUrl = "\(urlServer)\(urlList)"

        //GET
        Alamofire
            .request(listUrl)
            .responseJSON { resData in // method defaults to `.get`
                //エラーなら終了
                if resData.error != nil {
                    closureCompletion?(false, nil)
                    return
                }
                
                guard let response = resData.response else {
                    closureCompletion?(false, nil)
                    return
                }
                
                if response.statusCode != 200 {
                    closureCompletion?(false, nil)
                    return
                }
                
                guard let resultsData = resData.data else {
                    closureCompletion?(false, nil)
                    return
                }
                closureCompletion?(true, resultsData)
        }
    }
    
    //Insert
    static func requestInsert(name: String, phoneNumber: String, closureCompletion: ((Bool) -> Void)?) {
        let insertUrl = "\(urlServer)\(urlInsert)"
        
        let parameters: [String: String] = [
            "Name": name,
            "PhoneNumber": phoneNumber
        ]
        //POST
        Alamofire
            .request(insertUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { resData in
                //エラーなら終了
                if resData.error != nil {
                    closureCompletion?(false)
                    return
                }
                closureCompletion?(true)
            }
    }
    
    //Delete
    static func requestDelete(seq: Int, closureCompletion: ((Bool) -> Void)?) {
        let deleteUrl = "\(urlServer)\(urlDelete)"
        let parameters: [String: String] = [
            "SEQ": "\(seq)"
        ]
        //DELETE
        Alamofire
            .request(deleteUrl, method: .delete, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { resData in
                guard resData.error == nil else {
                    closureCompletion?(false)
                    return
                }
                closureCompletion?(true)
        }
    }
}
