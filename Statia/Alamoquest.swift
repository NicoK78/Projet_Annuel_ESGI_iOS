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
    
    class func logout(view: ViewController){
        let alert = UIAlertController(title: "Déconnection", message: "Etes vous sur ?", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { (action) in
            view.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Non", style: .default, handler: nil))
        
        view.present(alert, animated: true)
    }
    
    
    
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
        Alamofire.request("http://localhost:8000/api/players/", method: .post, parameters: player.toJsonV2().dictionaryObject, encoding: JSONEncoding.default).responseObject { (response:DataResponse<Player>) in
            let player = response.result.value
            if let player = player {
                completionHandler(player)
            }
        }
    }
    
    class func putPlayer(player:Player, id:Int, completionHandler: @escaping (_ player:Player) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/players/\(id)/", method: .put, parameters: player.toJSONUpdate().dictionaryObject, encoding: JSONEncoding.default).responseObject { (response:DataResponse<Player>) in
            let player = response.result.value
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
    
    class func getCompoDefault(completionHandler: @escaping (_ postes: [Composition]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/getcompodefault/").responseArray { (response: DataResponse<[Composition]>) in
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
        Alamofire.request("http://localhost:8000/api/compositionsdetails/", method: .post, parameters: compo.toJsonCreate().dictionaryObject, encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<CompositionDetails>) in
            let compo = response.result.value
            if let compo = compo {
                completionHandler(compo)
            }
        }
    }
    
//    class func postCompositionDetailsArray(compo: [CompositionDetails], completionHandler: @escaping (_ Composition:CompositionDetails) -> Void) {
//        Alamofire.request("http://localhost:8000/api/compositionsdetails/", method: .post, parameters: compo.toJSON(), encoding: JSONEncoding.default,headers: [:]).responseObject { (response:DataResponse<CompositionDetails>) in
//            let compo = response.result.value
//            if let compo = compo {
//                completionHandler(compo)
//            }
//        }
//    }
    
    class func deleteCompo(compo:Composition, completionHandler: @escaping (_ Result:Bool) -> Void) {
        Alamofire.request("http://localhost:8000/api/compositions/\(compo.id!)/", method: .delete, parameters: compo.toJSON(), encoding: URLEncoding.httpBody).response(completionHandler: { (response) in
            completionHandler(true)
        })
    }
    
    
    class func getStatsMatchByMatch(idMatch:Int, completionHandler: @escaping (_ statsMatch: [StatsMatch]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/statsmatchbymatch/\(idMatch)").responseArray { (response: DataResponse<[StatsMatch]>) in
            let statM = response.result.value
            if let statM = statM {
                completionHandler(statM)
            }
        }
    }
    
    class func getStatsMatchInfoByMatch(idMatch:Int, idTeam:Int, completionHandler: @escaping (_ statsMatch: [StatsMatchInfo]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/statsmatchinfobymatch/\(idMatch)/\(idTeam)").responseArray { (response: DataResponse<[StatsMatchInfo]>) in
            let statMI = response.result.value
            if let statMI = statMI {
                completionHandler(statMI)
            }
        }
    }
    
    
    class func getCategorie(completionHandler: @escaping (_ categorie: [Categorie]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/categoriestats/").responseArray { (response: DataResponse<[Categorie]>) in
            let categorie = response.result.value
            if let categorie = categorie {
                completionHandler(categorie)
            }
        }
    }
    
    class func getStatsInfo(completionHandler: @escaping (_ statsInfo: [StatsInfo]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/statsinfo/").responseArray { (response: DataResponse<[StatsInfo]>) in
            let statsInfo = response.result.value
            if let statsInfo = statsInfo {
                completionHandler(statsInfo)
            }
        }
    }
    
    class func deleteCompoDetail(idCompositionDetail: Int, completionHandler: @escaping (_ retour:Bool) -> Void){
        Alamofire.request("http://localhost:8000/api/compositionsdetails/\(idCompositionDetail)/", method: .delete, encoding: URLEncoding.httpBody).response { (response) in
            completionHandler(true)
        }
    }
    
    
}



