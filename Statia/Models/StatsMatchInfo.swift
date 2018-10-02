//
//  StatsMatchInfo.swift
//  Statia
//
//  Created by Selom Viadenou on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class StatsMatchInfo : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        statsInfo <- map["stats_info"]
        value <- map["value"]
    }
    
    var id : Int!
    var statsInfo = StatsInfo()
    var value:Float!


}
