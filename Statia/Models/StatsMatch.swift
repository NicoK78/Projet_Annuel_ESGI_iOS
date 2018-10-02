//
//  StatsMatch.swift
//  Statia
//
//  Created by Selom Viadenou on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class StatsMatch : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idStatistiquesMatch"]
        match <- map["match"]
        team <- map["team"]
        
    }
    
    var id : Int!
    var match: Int!
    var team:Int!
}
