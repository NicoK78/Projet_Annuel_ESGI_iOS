//
//  StatsMatchViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import ViewAnimator
import GTProgressBar

class StatsMatchViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblTeamHome: UILabel!
    @IBOutlet var lblTeamAway: UILabel!
    @IBOutlet var lblCompetition: UILabel!
    @IBOutlet var lblScoreHome: UILabel!
    @IBOutlet var lblScoreAway: UILabel!
    @IBOutlet var btnStats: UIButton!
    @IBOutlet var btnCompo: UIButton!
    
    @IBOutlet var tableViewCompo: UITableView!
    var match = Match()
    var statsMatchInfoHome = [StatsMatchInfo]()
    var statsMatchInfoAway = [StatsMatchInfo]()
    var categorieArray = [Categorie]()
    var statsInfoArray = [StatsInfo]()

    var composArray = [CompositionDetails]()
    
    var tableViewOption = [Int : Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName:"StatsMatchTableViewCell",bundle:nil), forCellReuseIdentifier: "statsMatchCell")
        self.tableView.register(UINib(nibName:"StatsMatchFistTableViewCell",bundle:nil), forCellReuseIdentifier: "statsMatchCellFirst")
        let headerNib = UINib.init(nibName: "PlayerCreateViewController", bundle: nil)
        self.tableView.backgroundColor = .clear
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
        self.lblTeamHome.text = self.match.home.club.name ?? ""
        self.lblTeamAway.text = self.match.away.club.name ?? ""
        self.lblCompetition.text = self.match.tournament.name ?? ""
        self.lblScoreHome.text = "\(self.match.homeGoal ?? 0)"
        self.lblScoreAway.text = "\(self.match.awayGoal ?? 0)"
        // Do any additional setup after loading the view.
        
        self.tableViewCompo.delegate = self
        self.tableViewCompo.dataSource = self
        
        
        self.btnStats.addTarget(self, action: #selector(self.showStats), for: .touchUpInside)
        self.btnCompo.addTarget(self, action: #selector(self.showCompo), for: .touchUpInside)
        Alamoquest.getStatsMatchInfoByMatch(idMatch: self.match.id, idTeam: self.match.home.id) { (statsIMArray) in
            for s in statsIMArray{
                self.statsMatchInfoHome.append(s)
            }
            Alamoquest.getStatsMatchInfoByMatch(idMatch: self.match.id, idTeam: self.match.away.id) { (statsIMArray) in
                for s in statsIMArray{
                    self.statsMatchInfoAway.append(s)
                }
                
                self.tableView.reloadData()
                self.initForTableView()
                self.manageCategorie()
                
                
            }


        }
        
        
        
        self.initComposition()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initForTableView(){
        for statsInfo in self.statsMatchInfoHome {
            if(self.tableViewOption[statsInfo.statsInfo.categorie.id] == nil){
                self.tableViewOption[statsInfo.statsInfo.categorie.id] = 1
            }else{
                self.tableViewOption[statsInfo.statsInfo.categorie.id] = self.tableViewOption[statsInfo.statsInfo.categorie.id]! + 1
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableViewCompo){
            return self.composArray.count
        }
        let tableSorted = self.tableViewOption.sorted(by: <)
        let count = self.tableViewOption[tableSorted[section].key]
        
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == self.tableViewCompo){
            var cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "\(self.composArray[indexPath.row].player?.user.firstname ?? "") \(self.composArray[indexPath.row].player?.user.name ?? "") \(self.composArray[indexPath.row].poste.role ?? "") \(self.composArray[indexPath.row].poste.cote ?? "")"
            cell.selectionStyle = .none
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            return cell
        }
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
        let tableSorted = self.tableViewOption.sorted(by: <)
        let id = tableSorted[indexPath.section].key
        for statMI in self.statsMatchInfoHome{
            if(statMI.statsInfo.categorie.id == id){
                tempArrayHome.append(statMI)
            }
        }
        
        for statMI in self.statsMatchInfoAway{
            if(statMI.statsInfo.categorie.id == id){
                tempArrayAway.append(statMI)
            }
        }
        
        cell.progressBar.isHidden = true
        if(id == 1 || id == 4 ){
            var total:Int = Int((tempArrayHome[indexPath.row].value)! + (tempArrayAway[indexPath.row].value)!)
            var temp:Float = 0
            if((tempArrayHome[indexPath.row].value)! > (tempArrayAway[indexPath.row].value)!){
                cell.labelHome.textColor = UIColor.red
                cell.labelAway.textColor = .black
                temp = Float((tempArrayHome[indexPath.row].value)! * 100 / Float(total))
                cell.progressBar.direction = GTProgressBarDirection.clockwise
            }else if((tempArrayHome[indexPath.row].value)! < (tempArrayAway[indexPath.row].value)!){
                cell.labelAway.textColor = UIColor.red
                cell.labelHome.textColor = .black
                temp = Float((tempArrayAway[indexPath.row].value)! * 100 / Float(total))
                cell.progressBar.direction = GTProgressBarDirection.anticlockwise
            }
            
            

            cell.progressBar.progress = CGFloat(temp / 100)
//            cell.progressBar.animateTo(progress: CGFloat(temp / 100))
            cell.progressBar.barFillColor = UIColor(red: 0.0, green: 173/255, blue: 213/255, alpha: 1.0)
            cell.progressBar.barBackgroundColor = UIColor(red: 24/255, green: 120/255, blue: 204/255, alpha: 1.0)// .clear
            cell.progressBar.barBorderWidth = 0
            cell.progressBar.isHidden = false
            
            
            
        }

        cell.labelHome.text = "\((tempArrayHome[indexPath.row].value)!)"
        cell.labelAway.text = "\((tempArrayAway[indexPath.row].value)!)"
        cell.labelStat.text = tempArrayHome[indexPath.row].statsInfo.name
        
        
        cell.selectionStyle = .none
        let animation = AnimationType.zoom(scale: 0.2)
        cell.animate(animations: [animation])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear //UIColor(red: 37, green: 132, blue: 204, alpha: 1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == self.tableViewCompo){
            return 1
        }
        return self.tableViewOption.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView == self.tableViewCompo){
            return "Composition"
        }
        let tableSorted = self.tableViewOption.sorted(by: <)
        let id = tableSorted[section].key
        for cateorie in self.categorieArray {
            if(cateorie.id == id){
                return cateorie.name
            }
        }
        
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var name = ""
        if(tableView == self.tableView){
            let tableSorted = self.tableViewOption.sorted(by: <)
            let id = tableSorted[section].key
            
            for cateorie in self.categorieArray {
                if(cateorie.id == id){
                    name = cateorie.name
                    break
                }
            }
        }

        let headerText = UILabel()
        headerText.textColor = UIColor.black
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        headerText.font = UIFont.boldSystemFont(ofSize: 22)
        headerText.text = name //self.categorieArray[section].name
        /*if(section == 0){
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! StatsMatchSectionHeader
            
            headerView.labelHome.text = "\((self.match.home.club.name)!)"
            headerView.labelAway.text = "\((self.match.away.club.name)!)"
            headerView.labelTitre.text = self.categorieArray[section].name
            return headerView

        }else{
            headerText.text = self.categorieArray[section].name
        }*/


        if(tableView == self.tableViewCompo){
            headerText.text = "Composition"
        }
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
    
    @objc func showStats(sender: UIButton){

        if(self.tableView.alpha == 1.0){
            return
        }
        let fade = AnimationType.from(direction: .right, offset: 0)
        //        self.tableView.animate(animations: [fade],initialAlpha: 1.0, finalAlpha: 0.0)
        self.tableViewCompo.animate(animations: [fade], reversed: true,initialAlpha: 1.0, finalAlpha: 0.0)
        
        let fadeIn = AnimationType.from(direction: .right, offset: 100.0)
//        self.tableView.animate(animations: [fade],initialAlpha: 1.0, finalAlpha: 0.0)
        self.tableView.animate(animations: [fadeIn], reversed: false,initialAlpha: 0.0, finalAlpha: 1.0)
    }
    
    @objc func showCompo(sender: UIButton){
        if(self.tableViewCompo.alpha == 1.0){
            return
        }
        let fade = AnimationType.from(direction: .right, offset: 0)
        //        self.tableView.animate(animations: [fade],initialAlpha: 1.0, finalAlpha: 0.0)
        self.tableView.animate(animations: [fade], reversed: true,initialAlpha: 1.0, finalAlpha: 0.0)
        
        let fadeIn = AnimationType.from(direction: .left, offset: 100.0)
        self.tableViewCompo.animate(animations: [fadeIn], initialAlpha: 0.0, finalAlpha: 1.0)

    }
    
    
    func initComposition(){
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getCompoForMatch(idMatch: self.match.id, idTeam: idTeam) { (composHistory) in
            print(composHistory.toJSON())
            Alamoquest.getComposDetailsHistoryByCompo(idcompo: composHistory.id, completionHandler: { (composArray) in
                self.composArray = composArray
                self.tableViewCompo.reloadData()
            })
            
        }
    }

}
