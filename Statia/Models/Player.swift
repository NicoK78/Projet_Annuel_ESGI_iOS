//
//  Player.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class Player :  Mappable {
    
    init(){}
    
    required convenience init?(map: Map) {
        self.init()
    }

    
    func mapping(map: Map) {
        print("MAP DATE \(map["birthdate"].currentValue)")

        id <- map["idplayer"]
        strongFoot <- map["foot"]
        mobile <- map["phone"]
        city <- map["city"]
        poste <- map["position"]
        user <- map["user"]
        team <- map["team"]
        birhtDate <- map["birthdate"]
    }
    
    func toJSON() -> [String: Any] {
        return [
            "position": poste as String,
            "foot" : strongFoot ?? "" as String,
            "phone" : mobile ?? "" as String,
            "mail" : user.email as String,
            "team" : team.id as Int,
            "first_name" : user.firstname as String,
            "last_name" : user.name as String,
            "username" : user.email as String
            //"foot" : strongFoot as Any
        ]
    }
    
    func toJsonV2() -> JSON {
        return [
            "position": poste as String,
            "foot" : strongFoot as String,
            "phone" : mobile as String,
            "mail" : user.email as String,
            "team" : team.id as Int,
            "user" : user.toJSON().dictionaryObject as! [String: Any],
            "birthdate" : birhtDate as String
//            "first_name" : user.firstname as String,
//            "last_name" : user.name as String,
//            "username" : user.email as String
        ]
    }
    
    func toJSONUpdate() -> JSON {
        return [
            "position": poste as String,
            "foot" : strongFoot as String,
            "phone" : mobile as String,
            "birthdate" : birhtDate as String,
            "user" : user.toJSON().dictionaryObject as! [String: Any]
            //"foot" : strongFoot as Any
        ]
    }
    
    var id :Int!
    var birhtDate : String!
    var poste : String!
    var strongFoot :String!
    var mobile : String!
    var city : String!
    var team = Team()
    var user = Users()
}
