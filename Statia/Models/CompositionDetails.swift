//
//  CompositionDetails.swift
//  Statia
//
//  Created by Selom Viadenou on 14/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class CompositionDetails : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        x <- map["x"]
        y <- map["y"]
        composition <- map["composition"]
        player <- map["player"]
        button <- map["button"]
        poste <- map["poste"]
        isSub <- map["is_sub"]
    }
    
    func toJsonCreate() -> JSON {
        if (player == nil){
            player = Player()
        }

        return [
            "x": x as Any,
            "y": y as Any,
            "composition": composition.id ?? "" as Any,
            "player" : player!.id ?? "" as Any,
            "button" : button as Any,
            "poste" : poste.id ?? "" as Any,
            "is_sub" : isSub as Any
        ]
    }
    
    var id : Int!
    var x: Float!
    var y: Float!
    var composition = Composition()
    var player :Player? = Player()
    var button: Int!
    var poste = Poste()
    var isSub :Int!
    
    class func getCompo(composdetails:[CompositionDetails], idCompo:Int, button:Int)->CompositionDetails{
        for composd in composdetails{
            if (composd.composition.id == idCompo && composd.button == button){
                return composd
            }
        }
        return CompositionDetails()
    }
    
}
