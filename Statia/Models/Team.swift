//
//  Team.swift
//  Statia
//
//  Created by Selom Viadenou on 11/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Team : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idteam"]
        name <- map["name"]
        league <- map["league"]
        club <- map["club"]
    }
    
    var id : Int!
    var name : String!
    var league = League()
    var club = Club()
    
    class func getTeam(teams:[Team], id:Int)->Team{
        for team in teams{
            if (team.id == id){
                return team
            }
        }
        return Team()
    }
    
    
    
}

