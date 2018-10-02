//
//  StatsMatchViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class StatsMatchViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var match = Match()
    var statsMatchInfoHome = [StatsMatchInfo]()
    var statsMatchInfoAway = [StatsMatchInfo]()
    var categorieArray = [Categorie]()
    var statsInfoArray = [StatsInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName:"StatsMatchTableViewCell",bundle:nil), forCellReuseIdentifier: "statsMatchCell")
        self.tableView.register(UINib(nibName:"StatsMatchFistTableViewCell",bundle:nil), forCellReuseIdentifier: "statsMatchCellFirst")
        let headerNib = UINib.init(nibName: "PlayerCreateViewController", bundle: nil)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")

        // Do any additional setup after loading the view.
        
        Alamoquest.getStatsMatchInfoByMatch(idMatch: self.match.id, idTeam: self.match.home.id) { (statsIMArray) in
            for s in statsIMArray{
                self.statsMatchInfoHome.append(s)
            }
            Alamoquest.getStatsMatchInfoByMatch(idMatch: self.match.id, idTeam: self.match.away.id) { (statsIMArray) in
                for s in statsIMArray{
                    self.statsMatchInfoAway.append(s)
                }
                
                self.tableView.reloadData()
                self.manageCategorie()
            }


        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorieArray[section].nbItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StatsMatchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "statsMatchCell", for: indexPath) as! StatsMatchTableViewCell
        //let cell = StatsMatchTableViewCell()
        
        /*if(indexPath.row == 0 && indexPath.section == 0){
            let cell:StatsMatchFistTableViewCell = tableView.dequeueReusableCell(withIdentifier: "statsMatchCellFirst", for: indexPath) as! StatsMatchFistTableViewCell
            
            cell.homeLabel.text = "\((self.match.home.club.name)!)"
            cell.awayLabel.text = "\((self.match.away.club.name)!)"
            
            return cell
        }*/
        var tempArrayHome = [StatsMatchInfo]()
        var tempArrayAway = [StatsMatchInfo]()
        for statMI in self.statsMatchInfoHome{
            if(statMI.statsInfo.categorie.id == indexPath.section + 1){
                tempArrayHome.append(statMI)
            }
        }
        
        for statMI in self.statsMatchInfoAway{
            if(statMI.statsInfo.categorie.id == indexPath.section + 1){
                tempArrayAway.append(statMI)
            }
        }
        
        cell.progressBar.isHidden = true
        if(indexPath.section == 1 || indexPath.section == 4 ){
//            var total:Int = Int((tempArrayHome[indexPath.row].value)! + (tempArrayAway[indexPath.row].value)!)
//            
////            var temp:Float = Float((tempArrayHome[indexPath.row].value)! * 100 / total)
////            print("\(temp / 100) ")
//            cell.progressBar.progress = CGFloat(temp / 100)
//            cell.progressBar.isHidden = false
            
            
            
        }

        cell.labelHome.text = "\((tempArrayHome[indexPath.row].value)!)"
        cell.labelAway.text = "\((tempArrayAway[indexPath.row].value)!)"
        cell.labelStat.text = tempArrayHome[indexPath.row].statsInfo.name
        
        if((tempArrayHome[indexPath.row].value)! > (tempArrayAway[indexPath.row].value)!){
            cell.labelHome.textColor = UIColor.red
        }else if((tempArrayHome[indexPath.row].value)! < (tempArrayAway[indexPath.row].value)!){
            cell.labelAway.textColor = UIColor.red
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categorieArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.categorieArray[section].name
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textColor = UIColor.black
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        headerText.text = self.categorieArray[section].name
        /*if(section == 0){
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! StatsMatchSectionHeader
            
            headerView.labelHome.text = "\((self.match.home.club.name)!)"
            headerView.labelAway.text = "\((self.match.away.club.name)!)"
            headerView.labelTitre.text = self.categorieArray[section].name
            return headerView

        }else{
            headerText.text = self.categorieArray[section].name
        }*/


        
        return headerText
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func manageCategorie(){
        Alamoquest.getCategorie { (categories) in
            for c in categories {
                self.categorieArray.append(c)
                print(c.name)
            }
            
            Alamoquest.getStatsInfo(completionHandler: { (statsInfos) in
                for s in statsInfos{
                    self.statsInfoArray.append(s)
                    for c in self.categorieArray {
                        if(s.categorie.id == c.id){
                            c.nbItem = c.nbItem + 1
                        }
                    }
                }
                self.tableView.reloadData()
            })
        }
    }

}
