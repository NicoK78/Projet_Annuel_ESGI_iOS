//
//  StatsInfo.swift
//  Statia
//
//  Created by Selom Viadenou on 18/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class StatsInfo : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        categorie <- map["categorie"]
        
    }
    
    var id : Int!
    var name:String!
    var categorie = Categorie()
    
    
}
