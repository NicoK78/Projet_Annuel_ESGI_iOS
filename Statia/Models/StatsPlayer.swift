//
//  StatsPlayer.swift
//  Statia
//
//  Created by Nico on 04/10/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class StatsPlayer : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        idStatistiquesPlayer <- map["idStatistiquesMatch"]
        note <- map["note"]
        nbMatchPlayer <- map["nbMatchPlayer"]
        nbMatchTeam <- map["nbMatchTeam"]
        nbGoalPlayer <- map["nbGoalPlayer"]
        nbGoalTeam <- map["nbGoalTeam"]
        nbLastPassPlayer <- map["nbLastPassPlayer"]
        nbLastPassTeam <- map["nbLastPassTeam"]
        nbYellowCardPlayer <- map["nbYellowCardPlayer"]
        nbYellowCardTeam <- map["nbYellowCardTeam"]
        nbRedCardPlayer <- map["nbRedCardPlayer"]
        nbRedCardTeam <- map["nbRedCardTeam"]
        nbCleanSheet <- map["nbCleanSheet"]
        nbGoalAgainst <- map["nbGoalAgainst"]
        nbShotIn <- map["nbShotIn"]
        nbShotOut <- map["nbShotOut"]
        nbCapt <- map["nbCapt"]
        nbPush <- map["nbPush"]
        nbAir <- map["nbAir"]
        nbFoot <- map["nbFoot"]
        nbAirFail <- map["nbAirFail"]
        nbFootFail <- map["nbFootFail"]
    }
    
    var idStatistiquesPlayer: Int!
    var note: Int!
    var nbMatchPlayer: Int!
    var nbMatchTeam: Int!
    var nbGoalPlayer: Int!
    var nbGoalTeam: Int!
    var nbLastPassPlayer: Int!
    var nbLastPassTeam: Int!
    var nbYellowCardPlayer: Int!
    var nbYellowCardTeam: Int!
    var nbRedCardPlayer: Int!
    var nbRedCardTeam: Int!
    var nbCleanSheet: Int!
    var nbGoalAgainst: Int!
    var nbShotIn: Int!
    var nbShotOut: Int!
    var nbCapt: Int!
    var nbPush: Int!
    var nbAir: Int!
    var nbFoot: Int!
    var nbAirFail: Int!
    var nbFootFail: Int!
}
