//
//  Match.swift
//  Statia
//
//  Created by Selom Viadenou on 12/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Match : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idmatch"]
        home <- map["home"]
        away <- map["away"]
        tournament <- map["tournament"]
        date <- map["date"]
        homeGoal <- map["home_goal"]
        awayGoal <- map["away_goal"]
    }
    
    
    func toJSON() -> [String: Any] {
        return [
            "idmatch" : id as Any,
            "home": home.id as Any,
            "away": away.id as Any,
            "tournament": tournament.id as Any,
            "date" : date as Any,
            "home_goal" : homeGoal as Any,
            "away_goal" : awayGoal as Any
        ]
    }
    
    func toJsonCreate() -> [String: Any] {
        return [
            "home": home.id as Any,
            "away": away.id as Any,
            "tournament": tournament.id as Any,
            "date" : date as Any
        ]
    }
    
    var id : Int!
    var home = Team()
    var away = Team()
    var tournament = Competition()
    var date : String!
    var day : Int?
    var homeGoal :Int!
    var awayGoal: Int!
    
    
    
}
