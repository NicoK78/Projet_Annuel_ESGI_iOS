//
//  CompositionHistory.swift
//  Statia
//
//  Created by Selom Viadenou on 03/10/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class CompositionHistory : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        team <- map["team"]
        name <- map["name"]
        match <- map["match"]
    }
    
    func toJsonCreate() -> [String: Any] {
        return [
            "name": name ?? "" as String,
            "team" : team.id ?? "" as Any,
            "match": match.id ?? "" as Any
        ]
    }
    
    var id : Int!
    var name : String!
    var team = Team()
    var match = Match()
}
