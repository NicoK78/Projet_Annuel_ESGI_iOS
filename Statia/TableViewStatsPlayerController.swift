//
//  TableViewStatsPlayerController.swift
//  Statia
//
//  Created by Nico on 10/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TableViewStatsPlayerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var player = Player()
    var statsPlayer = StatsPlayer()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamoquest.getStatsInfoByPlayer(idPlayer: player.id!) { (stats) in
            self.statsPlayer = stats
            self.tableView.reloadData()
        }

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "StatsInfoPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "statsInfoIdentifier")
//        self.tableView.register(UINib(nibName: "ResponsibleTableViewCell", bundle: nil), forCellReuseIdentifier: "responsibleIdentifier")
        self.tableView.register(UINib(nibName: "StatsBarPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "statsBarIdentifier")
        self.tableView.register(UINib(nibName: "PlayTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "playTimeIdentifier")
        self.tableView.register(UINib(nibName: "SeasonResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "seasonResultsIdentifier")
        self.tableView.register(UINib(nibName: "ButsTableViewCell", bundle: nil), forCellReuseIdentifier: "butsIdentifier")
        self.tableView.register(UINib(nibName: "LastPassTableViewCell", bundle: nil), forCellReuseIdentifier: "lastPassIdentifier")
        self.tableView.register(UINib(nibName: "CardsTableViewCell", bundle: nil), forCellReuseIdentifier: "cardsIdentifier")
        self.tableView.register(UINib(nibName: "GoalTableViewCell", bundle: nil), forCellReuseIdentifier: "goalIdentifier")
        self.tableView.register(UINib(nibName: "HealthTableViewCell", bundle: nil), forCellReuseIdentifier: "healthIdentifier")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "background_blue.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if player.poste.contains("Gardien") {
            return 7
        } else {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.item {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "statsInfoIdentifier", for: indexPath)
            if let accessoryCell = cell as? StatsInfoPlayerTableViewCell {
                accessoryCell.picture.image = UIImage(named: "soccer-player.png")!
                accessoryCell.name.text = player.user.firstname + " " + player.user.name
                accessoryCell.date.text = player.birhtDate
                accessoryCell.email.text = player.user.email
                accessoryCell.city.text = player.city
                accessoryCell.post.text = player.poste
                accessoryCell.foot.text = player.strongFoot
                accessoryCell.phone.text = player.mobile
            }
//        case 1:
//            cell = tableView.dequeueReusableCell(withIdentifier: "responsibleIdentifier", for: indexPath)
//            if let accessoryCell = cell as? ResponsibleTableViewCell {
////                accessoryCell.name.text = player.
//            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "playTimeIdentifier", for: indexPath)
            if let accessoryCell = cell as? PlayTimeTableViewCell {
                if statsPlayer.nbGoalPlayer != nil {
                    accessoryCell.nbMatchs.text = "\(statsPlayer.nbMatchPlayer!) matchs (\(statsPlayer.nbMatchTeam!))"
                    let time = statsPlayer.nbMatchTeam*90
                    accessoryCell.nbMin.text = "\(time)min"
                    if statsPlayer.nbMatchTeam == 0 {
                        accessoryCell.average.text = "-- min/match"
                    } else {
                        accessoryCell.average.text = "\(Int(Float(time)/Float(statsPlayer.nbMatchTeam))) min/match"
                    }
                }
            }
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "seasonResultsIdentifier", for: indexPath)
            if let accessoryCell = cell as? SeasonResultsTableViewCell {
                if statsPlayer.nbGoalPlayer != nil {
                    accessoryCell.setResults(win: 8, draw: 1, lose: 3)
                    accessoryCell.setPVParticipation(goal: statsPlayer.nbGoalPlayer, pass: statsPlayer.nbLastPassPlayer)
                }
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "butsIdentifier", for: indexPath)
            if let accessoryCell = cell as? ButsTableViewCell {
                if statsPlayer.nbGoalPlayer != nil {
                    accessoryCell.setPVGoals(player: statsPlayer.nbGoalPlayer, team: statsPlayer.nbGoalTeam)
                    if statsPlayer.nbMatchPlayer == 0 {
                        accessoryCell.nbGoalPerMatch.text = "-- but(s) / match"
                    } else {
                        accessoryCell.nbGoalPerMatch.text = "\(Float(statsPlayer.nbGoalPlayer)/Float(statsPlayer.nbMatchPlayer)) but(s) / match"
                    }
                    if statsPlayer.nbGoalPlayer == 0 {
                        accessoryCell.goalForMin.text = "1 but toutes les -- min"
                    } else {
                        accessoryCell.goalForMin.text = "1 but toutes les \(Int(Float(statsPlayer.nbMatchPlayer*90)/Float(statsPlayer.nbGoalPlayer))) min"
                    }
                }
            }
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "lastPassIdentifier", for: indexPath)
            if let accessoryCell = cell as? LastPassTableViewCell {
                if statsPlayer.nbGoalPlayer != nil {
                    accessoryCell.setPVLastPass(player: statsPlayer.nbLastPassPlayer, team: statsPlayer.nbLastPassTeam)
                    if statsPlayer.nbMatchPlayer == 0 {
                        accessoryCell.nbPassPerMatch.text = "-- p. décisive(s) / match"
                    } else {
                        accessoryCell.nbPassPerMatch.text = "\(Float(statsPlayer.nbLastPassPlayer)/Float(statsPlayer.nbMatchPlayer)) p. décisive(s) / match"
                    }
                    if statsPlayer.nbLastPassPlayer == 0 {
                        accessoryCell.passForMin.text = "1 p. dé. toutes les -- min"
                    } else {
                        accessoryCell.passForMin.text = "1 p. dé. toutes les \(Int(Float(statsPlayer.nbMatchPlayer*90)/Float(statsPlayer.nbLastPassPlayer))) min"
                    }
                }
            }
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "cardsIdentifier", for: indexPath)
            if let accessoryCell = cell as? CardsTableViewCell {
                if statsPlayer.nbGoalPlayer != nil {
                    accessoryCell.nbYellowCard.text = "\(statsPlayer.nbYellowCardPlayer!)"
                    if statsPlayer.nbYellowCardTeam == 0 {
                        accessoryCell.nbTeamYellowCard.text = "--%)"
                    } else {
                        accessoryCell.nbTeamYellowCard.text = "\(statsPlayer.nbYellowCardTeam!) (\(Int((Float(statsPlayer.nbYellowCardPlayer)/Float(statsPlayer.nbYellowCardTeam))*100))%)"
                    }
                    if statsPlayer.nbMatchPlayer == 0 {
                        accessoryCell.nbAverageYellowCard.text = "-- / match"
                    } else {
                        accessoryCell.nbAverageYellowCard.text = "\(Float(statsPlayer.nbYellowCardPlayer)/Float(statsPlayer.nbMatchPlayer)) / match"
                    }
                    if statsPlayer.nbYellowCardPlayer == 0 {
                        accessoryCell.nbPerMinYellowCard.text = "-- min"
                    } else {
                        accessoryCell.nbPerMinYellowCard.text = "\(Int(Float(statsPlayer.nbMatchPlayer*90)/Float(statsPlayer.nbYellowCardPlayer))) min"
                    }

                    accessoryCell.nbRedCard.text = "\(statsPlayer.nbRedCardPlayer!)"
                    if statsPlayer.nbRedCardTeam == 0 {
                        accessoryCell.nbTeamRedCard.text = "--%)"
                    } else {
                        accessoryCell.nbTeamRedCard.text = "\(statsPlayer.nbRedCardTeam!) (\(Int((Float(statsPlayer.nbRedCardPlayer)/Float(statsPlayer.nbRedCardTeam))*100))%)"
                    }
                    if statsPlayer.nbMatchPlayer == 0 {
                        accessoryCell.nbAverageRedCard.text = "-- / match"
                    } else {
                        accessoryCell.nbAverageRedCard.text = "\(Float(statsPlayer.nbRedCardPlayer)/Float(statsPlayer.nbMatchPlayer)) / match"
                    }
                    if statsPlayer.nbRedCardPlayer == 0 {
                        accessoryCell.nbPerMinRedCard.text = "-- min"
                    } else {
                        accessoryCell.nbPerMinRedCard.text = "\(Int(Float(statsPlayer.nbMatchPlayer*90)/Float(statsPlayer.nbRedCardPlayer))) min"
                    }

                    accessoryCell.nbExpulsion.text = "\(statsPlayer.nbRedCardPlayer!) expulsion(s)"
                }
            }
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "goalIdentifier", for: indexPath)
            if let accessoryCell = cell as? GoalTableViewCell {
                if statsPlayer.nbGoalPlayer != nil {
                    accessoryCell.nbCleanSheet.text = "Clean-sheet(s) : \(statsPlayer.nbCleanSheet!)"
                    accessoryCell.longestSerie.text = "Plus longue série : XX"
                    accessoryCell.nbGoalForShot.text = "\(statsPlayer.nbGoalAgainst!) buts encaissés / \(statsPlayer.nbShotIn!) tirs cadrés"
                    if statsPlayer.nbGoalAgainst == 0 {
                        accessoryCell.goalForShot.text = "1 but encaissé tous les \(statsPlayer.nbShotIn!) tirs cadrés"
                        let time = statsPlayer.nbMatchTeam*90
                        accessoryCell.goalForMin.text = "1 but encaissé toutes les \(time) minutes"
                    } else {
                        accessoryCell.goalForShot.text = "1 but encaissé tous les \(Int(Float(statsPlayer.nbShotIn)/Float(statsPlayer.nbGoalAgainst))) tirs cadrés"
                        let time = statsPlayer.nbMatchTeam*90
                        accessoryCell.goalForMin.text = "1 but encaissé toutes les \(Int(Float(time)/Float(statsPlayer.nbGoalAgainst))) minutes"
                    }
                    accessoryCell.setPVSaveShot(save: statsPlayer.nbCapt + statsPlayer.nbPush, shot: statsPlayer.nbShotIn)
                    accessoryCell.setPVCapturedPushedBall(captured: statsPlayer.nbCapt, pushed: statsPlayer.nbPush)
                    let totalIntercept: Int = statsPlayer.nbAir + statsPlayer.nbFoot + statsPlayer.nbAirFail + statsPlayer.nbFootFail
                    let totalAirIntercept: Int = statsPlayer.nbAir + statsPlayer.nbAirFail
                    let totalFootIntercept: Int = statsPlayer.nbFoot + statsPlayer.nbFootFail
                    accessoryCell.nbIntercept.text = "\(totalIntercept) interceptions"
                    accessoryCell.nbAirGroundIntercept.text = "aériennes : \(totalAirIntercept) (\(totalAirIntercept == 0 ? 0 : Int((Float(statsPlayer.nbAir)/Float(totalAirIntercept))*100))% réussies)\nau sol : \(totalFootIntercept) (\(totalFootIntercept == 0 ? 0 : Int((Float(statsPlayer.nbFoot)/Float(totalFootIntercept))*100))% réussies)"
                }
            }
        case 7:
            cell = tableView.dequeueReusableCell(withIdentifier: "healthIdentifier", for: indexPath)
            if let accessoryCell = cell as? HealthTableViewCell {
//                accessoryCell.disponibility.text = "Indisponible"
//                accessoryCell.natureInjury.text = "Fracture rotule"
//                accessoryCell.timeIndisponibility.text = "Indisponible 26 jours"
//                accessoryCell.backDate.text = "Retour le 08/08/2018"
//                accessoryCell.recoveryDay.text = "13 jours de récupération"
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "statsBarIdentifier", for: indexPath)
            if let accessoryCell = cell as? StatsBarPlayerTableViewCell {
                
            }
        }
//        if indexPath.item % 2 == 0 {
//            cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//            if let accessoryCell = cell as? StatsInfoPlayerTableViewCell {
//                accessoryCell.backgroundColor = UIColor.lightGray
//            }
        
            //            accessoryCell.showAndHide.titleLabel?.text = "N° \(indexPath)"
            //            accessoryCell.showAndHide.addTarget(self, action: "showAndHideInfoPlayer:", for: .touchUpInside)
            
            //            accessoryCell.label.text = self.todos[indexPath.item].title
            //            if (self.todos[indexPath.item].tasks?.count)! <= 0 {
            //                accessoryCell.labelSousTitre.text = "Done"
            //            }else{
            //                let aTask: Task = self.todos[indexPath.item].tasks?.allObjects[0] as! Task
            //                accessoryCell.labelSousTitre.text = aTask.name
            //            }
            
//        } else {
//            cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellIdentifier", for: indexPath)
//            if let accessoryCell = cell as? StatsBarPlayerTableViewCell {
//
//            }
//        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click on \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return 100
//        case 1:
//            return 110
//            return 0
        case 1:
            return 60
        case 2:
            return 125
        case 3:
            return 120
        case 4:
            return 120
        case 5:
            return 280
        case 6:
            return 280
        case 7:
            return 150
        default:
            return 60
        }
    }

}
