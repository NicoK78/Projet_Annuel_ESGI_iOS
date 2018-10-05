//
//  EffectifViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import ViewAnimator

class EffectifViewController: UIViewController , UITableViewDelegate , UITableViewDataSource  {
    
    @IBOutlet var tableViewEffectif: UITableView!
    var playersTab = [Player]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        // Do any additional setup after loading the view.

        self.tableViewEffectif.dataSource = self
        self.tableViewEffectif.delegate = self

        self.tableViewEffectif.register(UINib(nibName:"TableViewCellEffectif",bundle:nil), forCellReuseIdentifier: "EffectifCell")
        //self.tableView.register(EffectifTableViewCell.self, forCellReuseIdentifier: "EffectifCell")
        self.tableViewEffectif.backgroundColor = UIColor.clear
    }
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var temp = 0
        switch section {
        case 0:
            for player in self.playersTab {
                if(player.poste.starts(with: "Gardien")){
                    temp += 1
                }
            }
            return temp
        case 1:
            for player in self.playersTab {
                if(player.poste.starts(with: "Défenseur")){
                    temp += 1
                }
            }
            return temp
        case 2:
            for player in self.playersTab {
                if(player.poste.starts(with: "Milieu")){
                    temp += 1
                }
            }
            return temp
        case 3:
            for player in self.playersTab {
                if(player.poste.starts(with: "Attaquant")){
                    temp += 1
                }
            }
            return temp
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Gardien"
        case 1:
            return "Défenseur"
        case 2:
            return "Milieux"
        case 3:
            return "Attaquant"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var playerTabTemp = [Player]()
        switch indexPath.section {
        case 0:
            for player in self.playersTab {
                if(player.poste.starts(with: "Gardien")){
                    playerTabTemp.append(player)
                }
            }

        case 1:
            for player in self.playersTab {
                if(player.poste.starts(with: "Défenseur")){
                    playerTabTemp.append(player)
                }
            }

        case 2:
            for player in self.playersTab {
                if(player.poste.starts(with: "Milieu")){
                    playerTabTemp.append(player)
                }
            }

        case 3:
            for player in self.playersTab {
                if(player.poste.starts(with: "Attaquant")){
                    playerTabTemp.append(player)
                }
            }

        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EffectifCell" ,for: indexPath) as! TableViewCellEffectif
        /*if cell == nil{
            if let effectifCell = cell as? EffectifTableViewCell {
                effectifCell.label.text = "Selom Junior"
                effectifCell.label2.text = "Viadenou"
                effectifCell.photoProfil.image =  UIImage(named: "soccer-player.png")!
            }
            
        }*/
        cell.labelNom.text = playerTabTemp[indexPath.row].user.name
        cell.labelPrenom.text = playerTabTemp[indexPath.row].user.firstname
        cell.labelPoste.text = playerTabTemp[indexPath.row].poste
        cell.photoProfil.image = UIImage(named: "soccer-player.png")!

        //cell = EffectifTableViewCell(style: .default, reuseIdentifier: "EffectifCell")
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "EffectifTableViewCell")
//        let zoomAnimation = AnimationType.zoom(scale: 0.5)
//        cell.animate(animations: [zoomAnimation], duration: 0.3)
        cell.backgroundColor = .clear//UIColor(red: 93/255, green: 176/255, blue: 213/255, alpha: 1.0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewPlayersController = TableViewStatsPlayerController(nibName: "TableViewStatsPlayerController", bundle: nil)
        self.navigationController?.pushViewController(tableViewPlayersController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tableViewEffectif.isHidden = true
        self.playersTab.removeAll()
        if(UserDefaults.standard.integer(forKey: "profil") == 1){
            self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayer))
        }

        print(UserDefaults.standard.integer(forKey: "team"))
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getPlayerByTeam(id: idTeam) { (players) in
            for player in players{
                self.playersTab.append(player)
                
            }
            
            self.tableViewEffectif.reloadData()
            self.tableViewEffectif.isHidden = false
            let cells = self.tableViewEffectif.visibleCells
            let fromAnimation = AnimationType.from(direction: .right, offset: 60.0)
             let zoomAnimation = AnimationType.zoom(scale: 0.5)
            UIView.animate(views: cells, animations: [zoomAnimation], duration: 0.3)
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 15, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(self.tableViewEffectif, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (UserDefaults.standard.integer(forKey: "profil") > 1){
            var playerTabTemp = [Player]()
            
            switch indexPath.section {
            case 0:
                for player in self.playersTab {
                    if(player.poste.starts(with: "Gardien")){
                        playerTabTemp.append(player)
                    }
                }
                
            case 1:
                for player in self.playersTab {
                    if(player.poste.starts(with: "Défenseur")){
                        playerTabTemp.append(player)
                    }
                }
                
            case 2:
                for player in self.playersTab {
                    if(player.poste.starts(with: "Milieu")){
                        playerTabTemp.append(player)
                    }
                }
                
            case 3:
                for player in self.playersTab {
                    if(player.poste.starts(with: "Attaquant")){
                        playerTabTemp.append(player)
                    }
                }
                
            default:
                break
            }
            print("\(playerTabTemp[indexPath.row].id ) \(UserDefaults.standard.integer(forKey: "idplayer"))")
            if(playerTabTemp[indexPath.row].id == UserDefaults.standard.integer(forKey: "idplayer")){
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var playerTabTemp = [Player]()

        switch indexPath.section {
        case 0:
            for player in self.playersTab {
                if(player.poste.starts(with: "Gardien")){
                    playerTabTemp.append(player)
                }
            }
            
        case 1:
            for player in self.playersTab {
                if(player.poste.starts(with: "Défenseur")){
                    playerTabTemp.append(player)
                }
            }
            
        case 2:
            for player in self.playersTab {
                if(player.poste.starts(with: "Milieu")){
                    playerTabTemp.append(player)
                }
            }
            
        case 3:
            for player in self.playersTab {
                if(player.poste.starts(with: "Attaquant")){
                    playerTabTemp.append(player)
                }
            }
            
        default:
            break
        }
        let update = UITableViewRowAction(style: .normal, title: "Modifier") { (action, indexPath) in
            let  updatePlayer = PlayerCreateV2ViewController()
            updatePlayer.mode = 1
            updatePlayer.player = playerTabTemp[indexPath.row]
            self.navigationController?.pushViewController(updatePlayer, animated: true)
        }
        
        return [update]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func addPlayer(){
//        let playerCreate = PlayerCreateViewController(nibName: "PlayerCreateViewController", bundle: nil)
//        self.navigationController?.pushViewController(playerCreate, animated: true)
        let playerCreate = PlayerCreateV2ViewController()
        self.navigationController?.pushViewController(playerCreate, animated: true)
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
