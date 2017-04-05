//
//  YelpClient.swift
//  Yelp
//
//  Created by yanze on 4/4/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import Foundation
import AFNetworking


enum YelpSortMode : Int {
    case bestMatch = 0, distance, highestRated
}

let baseUrl = "https://api.yelp.com/v3"
let token_type = "Bearer "
let access_token = "fqSUw_t2L1gr_rIXCZ8BdcQ67_mw0GcecL_WTX6IWPsXTAkwiX2xsOc6P-qOp7OuURfOBT4cBosO6GITfIPyMAm_JZXRkfzO4usuLzN-xLxcnkbJLTwulPiWoEDjWHYx"
//let appSecret = "EZGUolH7xETzGO3b6W806i1hN1XPq6PiVC6QMAPtcdDnxck1XOU5OWflMgUip4wu"
//let appId = "FRL1V8VH43JHR4eUWmI1FQ"

class YelpClient: NSObject {
    
    static var sharedInstance = YelpClient()
    
    func searchBusinessWith(_ term: String?, sort: YelpSortMode?, categories: [String]?, deals:Bool?) {
        let manager = AFHTTPSessionManager()
        let url = baseUrl.appending("/businesses/search")
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue(token_type.appending(access_token), forHTTPHeaderField: "Authorization")
        
        var parameters: [String: Any] = ["location": "sunnyvale"]
        
        if sort != nil {
            parameters["sort"] = sort?.rawValue as Any?
        }
        
        if categories != nil && (categories?.count)! > 0 {
            parameters["category_filter"] = (categories)?.joined(separator: ",") as Any?
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals as Any?
        }
        
        manager.get(url, parameters: parameters, progress: nil, success: { (operation, response) in
            print(response!)
            
        }) { (operation, error) in
            print(error)
        }
        
    }
    
    
}
