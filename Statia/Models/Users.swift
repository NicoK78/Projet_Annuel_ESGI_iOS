//
//  User.swift
//  Statia
//
//  Created by Selom Viadenou on 19/09/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class Users :  Mappable {
    
    init(){}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["last_name"]
        firstname <- map["first_name"]
        email <- map["email"]
    }
    
    func toJSON() -> JSON {
        return [
            "id":id ?? 0 as Int,
            "first_name": firstname as String,
            "last_name": name as String,
            "email" : email as String,
            "username" : email as String
        ]
    }
    
    var id :Int!
    var firstname : String!
    var name : String!
    var email : String!
}
