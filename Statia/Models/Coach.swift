//
//  Coach.swift
//  Statia
//
//  Created by Selom Viadenou on 11/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Coach :  Mappable {
    
    init(){}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["user.username"]
        name <- map["user.last_name"]
        firstname <- map["user.first_name"]
        email <- map["user.mail"]
    }
    
    func toJSON() -> [String: Any] {
        return [
            "username" : username as Any,
            "firstname": firstname as Any,
            "lastname": name as Any,
            "mail" : email as Any
            //"foot" : strongFoot as Any
        ]
    }
    
    var id :Int!
    var username: String!
    var firstname : String!
    var name : String!
    var email :String!

}
