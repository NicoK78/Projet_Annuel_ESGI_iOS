//
//  ResultatSecondViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 13/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import ViewAnimator


class ResultatSecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableViewTeam: UITableView!
    var idCompetition = 0
    var matchArray = [Match]()
    var teamArray = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableViewTeam.delegate = self
        self.tableViewTeam.dataSource = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        self.tableView.backgroundColor = .clear
        self.tableViewTeam.backgroundColor = .clear
        self.tableView.register(UINib(nibName:"MatchTableViewCell",bundle:nil), forCellReuseIdentifier: "matchCell")
        self.tableViewTeam.register(UINib(nibName: "TeamResultatTableViewCell", bundle: nil), forCellReuseIdentifier: "teamResultCell")
        // Do any additional setup after loading the view.
        print(idCompetition)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableView){
             return self.matchArray.count
        }else{
            return self.teamArray.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == self.tableView){
            let zoom = AnimationType.zoom(scale: 0.5)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.animate(animations: [zoom], completion: {
                Alamoquest.getStatsMatchByMatch(idMatch: self.matchArray[indexPath.row].id) { (statsArray) in
                    print(statsArray.count)
                    if(statsArray.count == 2){
                        let statView = StatsMatchViewController()
                        statView.match = self.matchArray[indexPath.row]
                        self.navigationController?.pushViewController(statView, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Statistiques", message: "Les statistiques ne sont pas encore disponible.", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                    }
                }

            })
           
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.tableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell" ,for: indexPath) as! MatchTableViewCell
            
            cell.homeClublabel.text = self.matchArray[indexPath.row].home.club.name
            cell.homeTeamlabel.text = self.matchArray[indexPath.row].home.name
            cell.awayClublabel.text = self.matchArray[indexPath.row].away.club.name
            cell.awayTeamLabel.text = self.matchArray[indexPath.row].away.name
            cell.competitionLabel.text = self.matchArray[indexPath.row].tournament.name
            cell.labelDate.text = self.matchArray[indexPath.row].date
            cell.homeGoalLabel.text = "-"
            cell.awayGoalLabel.text = "-"
            if (self.matchArray[indexPath.row].homeGoal != nil && self.matchArray[indexPath.row].awayGoal != nil){
                cell.homeGoalLabel.text = String(self.matchArray[indexPath.row].homeGoal)
                cell.awayGoalLabel.text = String(self.matchArray[indexPath.row].awayGoal)
            }
            
            if (self.matchArray[indexPath.row].date != nil){
                let formater = DateFormatter()
                formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                formater.timeZone = TimeZone(abbreviation: "UTC")
                formater.locale = Locale(identifier: "FR-fr")
                print(self.matchArray[indexPath.row].date)
                let dateMatch = formater.date(from: self.matchArray[indexPath.row].date)
                
                formater.dateStyle = DateFormatter.Style.medium
                formater.timeStyle = DateFormatter.Style.short
                cell.labelDate.text = formater.string(from: dateMatch!)
            }
            
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamResultCell" ,for: indexPath) as! TeamResultatTableViewCell
            
            cell.labelTeam.text = "\(self.teamArray[indexPath.row].club.name!) \(self.teamArray[indexPath.row].name!)"
            cell.btnAdd.addTarget(self, action: #selector(addMatch(sender:)), for: .touchDown)
            cell.btnAdd.tag = self.teamArray[indexPath.row].id!
            if(UserDefaults.standard.integer(forKey: "profil") > 1){
                cell.btnAdd.isEnabled = false
                cell.btnAdd.isHidden = true
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.matchArray.removeAll()
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getMatchByTeamAndCompet(idteam: idTeam, idCompet: self.idCompetition){ (matchs) in
            for match in matchs {
                self.matchArray.append(match)
                self.tableView.reloadData()
            }
        }
        let idLeague = UserDefaults.standard.integer(forKey: "idleague")
        Alamoquest.getTeamByLeague(idLeague: idLeague) { (teams) in
            for team in teams {
                self.teamArray.append(team)
                self.tableViewTeam.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == self.tableView){
            return 100
        }
        return 50
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        if (tableView == self.tableView){
//            let action = UITableViewRowAction(style: .normal, title: "Score") { (action, indexPath) in
//                let alert = UIAlertController(title: "Score", message: "\(self.matchArray[indexPath.row].home.club.name!) vs \(self.matchArray[indexPath.row].away.club.name!)", preferredStyle: .alert)
//
//
//
//                alert.addTextField(configurationHandler: { (textField) in
//                    textField.placeholder = "Score : \(self.matchArray[indexPath.row].home.club.name!) \(self.matchArray[indexPath.row].home.name!)"
//                })
//
//                alert.addTextField(configurationHandler: { (textField) in
//                    textField.placeholder = "Score : \(self.matchArray[indexPath.row].away.club.name!) \(self.matchArray[indexPath.row].away.name!)"
//                })
//
//                alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {action in
//                    let firstTxt = alert.textFields![0] as UITextField
//                    let second = alert.textFields![1] as UITextField
//                    let matchUpdate = self.matchArray[indexPath.row]
//                    matchUpdate.homeGoal = Int(firstTxt.text!)
//                    matchUpdate.awayGoal = Int(second.text!)
//
//                    Alamoquest.updateMatch(match: matchUpdate, completionHandler: { (match) in
//                        print("Sucess \(match)")
//                        let idLeague = UserDefaults.standard.integer(forKey: "idleague")
//                        Alamoquest.getTeamByLeague(idLeague: idLeague) { (teams) in
//                            for team in teams {
//                                self.teamArray.append(team)
//                                self.tableViewTeam.reloadData()
//                            }
//                        }
//                    })
//                }))
//                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
//
//                self.present(alert, animated: true)
//            }
//
//
//            return [action]
//        }else{
//            return nil
//        }
//
//
//    }
    
    
    @objc func addMatch(sender: UIButton){
        print("Add player")
        var matchAdd = Match()
        matchAdd.tournament = Competition()
        matchAdd.tournament.id = idCompetition
        
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        matchAdd.home = Team.getTeam(teams: self.teamArray, id: idTeam)
        matchAdd.away = Team.getTeam(teams: self.teamArray, id: sender.tag)
        
        let createMatch = CalendrierCreateViewController()
        createMatch.mode = 2
        createMatch.matchUpdate = matchAdd
        self.navigationController?.pushViewController(createMatch, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


