//
//  Categorie.swift
//  Statia
//
//  Created by Selom Viadenou on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Categorie : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        
    }
    
    var id : Int!
    var name:String!
    var nbItem:Int! = 0


}
