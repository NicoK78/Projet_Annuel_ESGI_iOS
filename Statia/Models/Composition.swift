//
//  Composition.swift
//  Statia
//
//  Created by Selom Viadenou on 14/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Composition : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        team <- map["team"]
        name <- map["name"]
    }
    
    func toJsonCreate() -> [String: Any] {
        return [
            "name": name as String,
            "team" : team.id as Any
        ]
    }
    
    var id : Int!
    var name : String!
    var team = Team()
}
