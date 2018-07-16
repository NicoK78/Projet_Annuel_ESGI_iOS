//
//  Competition.swift
//  Statia
//
//  Created by Selom Viadenou on 13/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Competition : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idCompetition"]
        name <- map["name"]
        
    }
    
    var id : Int!
    var name: String!
}
