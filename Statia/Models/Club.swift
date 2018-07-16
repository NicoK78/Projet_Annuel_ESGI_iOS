//
//  Team.swift
//  Statia
//
//  Created by Selom Viadenou on 03/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Club : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idclub"]
        address <- map["adress"]
        city <- map["city"]
        creationdate <- map["creationdate"]
        department <- map["department"]
        name <- map["name"]
        stadename <- map["stadename"]
    }
    
    var id : Int?
    var address : String?
    var city : String?
    var creationdate : String?
    var department : Int?
    var name : String?
    var stadename : String?
    
    
    
}
