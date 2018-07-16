//
//  Alamoquest.swift
//  Statia
//
//  Created by Selom Viadenou on 03/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

public class Alamoquest{
    
    let headers: HTTPHeaders = [
        "X-CSRFToken": "TjoxdRteZJJtL6K1wCk6xcBq4QyBz8LORRttJcf5OkOLgvxNlHsAthSt1cC8Gtrm",
        "Content-Type": "application/json"
    ]
    
    
    
    class func login(parameter:Parameters , completionHandler: @escaping (_ coach:JSON) -> Void){
        Alamofire.request("http://localhost:8000/api/login/", method: .post, parameters: parameter, encoding: URLEncoding.httpBody).responseJSON { response in
            if var json = response.result.value {
                var json = JSON(json)
                
                if(json != false){
                    let idclub = json["team"]["club"]["idclub"].int
                    let nameclub = json["team"]["club"]["name"].string

                    UserDefaults.standard.set(idclub, forKey: "idclub")
                    UserDefaults.standard.set(nameclub, forKey: "nameclub")
                }
                completionHandler(json)
            }
        }
    }
    
    class func getTeam(completionHandler: @escaping (_ teams: [Team]) -> Void) {
        let idclub = UserDefaults.standard.integer(forKey: "idclub")
        Alamofire.request("http://127.0.0.1:8000/api/teambyClub/\(idclub)").responseArray { (response: DataResponse<[Team]>) in
            let teams = response.result.value
            
            if let teams = teams {
                completionHandler(teams)
            }
        }
    
    }
    
    class func getPlayerByTeam(id: Int, completionHandler: @escaping (_ teams: [Player]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/playersbyteam/\(id)").responseArray { (response: DataResponse<[Player]>) in
            let teams = response.result.value
            print(teams)
            if let teams = teams {
                completionHandler(teams)
            }
        }
        
    }
    
    class func getPoste(completionHandler: @escaping (_ postes: [Poste]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/poste").responseArray { (response: DataResponse<[Poste]>) in
            let postes = response.result.value
            
            if let postes = postes {
                completionHandler(postes)
            }
        }
    }
    
    
    class func postPlayer(player:Player, completionHandler: @escaping (_ player:Player) -> Void) {
        Alamofire.request("http://localhost:8000/api/players/", method: .post, parameters: player.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<Player>) in
            let player = response.result.value
            print(player)
            if let player = player {
                completionHandler(player)
            }
        }
    }
    
    
    class func getMatchByTeam(idteam:Int, completionHandler: @escaping (_ postes: [Match]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/matchbyteam/\(idteam)").responseArray { (response: DataResponse<[Match]>) in
            let match = response.result.value
            
            if let match = match {
                completionHandler(match)
            }
        }
    }
    
    class func getMatchByTeamAndCompet(idteam:Int, idCompet:Int, completionHandler: @escaping (_ postes: [Match]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/matchbyteamandcompet/\(idteam)/\(idCompet)").responseArray { (response: DataResponse<[Match]>) in
            let match = response.result.value
            
            if let match = match {
                completionHandler(match)
            }
        }
    }
    
    class func getTeamByLeague(idLeague:Int, completionHandler: @escaping (_ teams: [Team]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/teambyleague/\(idLeague)").responseArray { (response: DataResponse<[Team]>) in
            let teams = response.result.value
            
            if let teams = teams {
                completionHandler(teams)
            }
        }
        
    }
    
    class func postMatch(match:Match, completionHandler: @escaping (_ Match:Match) -> Void) {
        Alamofire.request("http://localhost:8000/api/matchs/", method: .post, parameters: match.toJsonCreate(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<Match>) in
            let match = response.result.value
            print(match)
            if let match = match {
                completionHandler(match)
            }
        }
    }
    
    class func updateMatch(match:Match, completionHandler: @escaping (_ Match:Match) -> Void) {
        Alamofire.request("http://localhost:8000/api/matchs/\(match.id!)/", method: .put, parameters: match.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<Match>) in
            let match = response.result.value
            print(match)
            if let match = match {
                completionHandler(match)
            }
        }
    }
    
    class func deleteMatch(match:Match, completionHandler: @escaping (_ Result:Bool) -> Void) {
        Alamofire.request("http://localhost:8000/api/matchs/\(match.id!)/", method: .delete, parameters: match.toJSON(), encoding: URLEncoding.httpBody).response(completionHandler: { (response) in
             completionHandler(true)
        })
    }
    
    class func postComposition(compo:Composition, completionHandler: @escaping (_ Composition:Composition) -> Void) {
        Alamofire.request("http://localhost:8000/api/compositions/", method: .post, parameters: compo.toJsonCreate(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<Composition>) in
            let compo = response.result.value
            if let compo = compo {
                completionHandler(compo)
            }
        }
    }
    
    
    class func getCompoByTeam(idteam:Int, completionHandler: @escaping (_ postes: [Composition]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/getcompobyteam/\(idteam)").responseArray { (response: DataResponse<[Composition]>) in
            let compo = response.result.value
            if let compo = compo {
                completionHandler(compo)
            }
        }
    }
    
    class func getComposDetailsByCompo(idcompo:Int, completionHandler: @escaping (_ postes: [CompositionDetails]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/getcomposdetails/\(idcompo)").responseArray { (response: DataResponse<[CompositionDetails]>) in
            let compoDetails = response.result.value
            if let compoDetails = compoDetails {
                completionHandler(compoDetails)
            }
        }
    }
    
    class func postCompositionDetails(compo:CompositionDetails, completionHandler: @escaping (_ Composition:CompositionDetails) -> Void) {
        Alamofire.request("http://localhost:8000/api/compositionsdetails/", method: .post, parameters: compo.toJsonCreate(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<CompositionDetails>) in
            let compo = response.result.value
            if let compo = compo {
                completionHandler(compo)
            }
        }
    }
    
    class func deleteCompo(compo:Composition, completionHandler: @escaping (_ Result:Bool) -> Void) {
        Alamofire.request("http://localhost:8000/api/compositions/\(compo.id!)/", method: .delete, parameters: compo.toJSON(), encoding: URLEncoding.httpBody).response(completionHandler: { (response) in
            completionHandler(true)
        })
    }
    
    
}



