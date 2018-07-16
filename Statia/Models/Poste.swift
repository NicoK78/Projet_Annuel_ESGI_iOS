//
//  Poste.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//
import Foundation
import ObjectMapper


class Poste : Mappable , CustomStringConvertible{
    var description: String {return "\(self.role ?? "") \(self.cote ?? "")"}
    
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        role <- map["role"]
        cote <- map["cote"]
    }
    
    var id:Int?
    var role:String?
    var cote:String?
    
    

    
}
