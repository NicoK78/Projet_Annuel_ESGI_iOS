//
//  JSONArrayEnconding.swift
//  Statia
//
//  Created by Selom Viadenou on 27/09/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct JSONEncodingArray: ParameterEncoding {
    private let array: [String]
    
    init(array: [String]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
    
    
}
