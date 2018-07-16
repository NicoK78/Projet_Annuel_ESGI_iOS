//
//  CalendrierViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 15/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CalendrierViewController: UIViewController,UITableViewDelegate , UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var matchArray = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName:"MatchTableViewCell",bundle:nil), forCellReuseIdentifier: "matchCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.matchArray.removeAll()
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCalendrier))
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getMatchByTeam(idteam: idTeam) { (matchs) in
            for match in matchs {
                print(match)
                self.matchArray.append(match)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell" ,for: indexPath) as! MatchTableViewCell
        /*if cell == nil{
         if let effectifCell = cell as? EffectifTableViewCell {
         effectifCell.label.text = "Selom Junior"
         effectifCell.label2.text = "Viadenou"
         effectifCell.photoProfil.image =  UIImage(named: "soccer-player.png")!
         }
         
         }*/
        cell.homeClublabel.text = self.matchArray[indexPath.row].home.club.name
        cell.homeTeamlabel.text = self.matchArray[indexPath.row].home.name
        cell.awayClublabel.text = self.matchArray[indexPath.row].away.club.name
        cell.awayTeamLabel.text = self.matchArray[indexPath.row].away.name
        cell.competitionLabel.text = self.matchArray[indexPath.row].tournament.name
        cell.labelDate.text = self.matchArray[indexPath.row].date
        cell.homeGoalLabel.text = ""
        cell.awayGoalLabel.text = ""
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

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @objc private func addCalendrier(){
        let calendrierCreate = CalendrierCreateViewController(nibName: "CalendrierCreateViewController", bundle: nil)
        calendrierCreate.mode = 0
        self.navigationController?.pushViewController(calendrierCreate, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            Alamoquest.deleteMatch(match: self.matchArray[indexPath.row], completionHandler: { (result) in
                self.matchArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            })
            
        }
        
        
        let update = UITableViewRowAction(style: .normal, title: "Modifier") { (action, indexPath) in
            let  updateMatch = CalendrierCreateViewController()
            updateMatch.matchUpdate = self.matchArray[indexPath.row]
            updateMatch.mode = 1
            self.navigationController?.pushViewController(updateMatch, animated: true)
        }

        
        return [delete,update]
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
