//
//  EffectifViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

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
        
    }
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playersTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EffectifCell" ,for: indexPath) as! TableViewCellEffectif
        /*if cell == nil{
            if let effectifCell = cell as? EffectifTableViewCell {
                effectifCell.label.text = "Selom Junior"
                effectifCell.label2.text = "Viadenou"
                effectifCell.photoProfil.image =  UIImage(named: "soccer-player.png")!
            }
            
        }*/
        cell.labelNom.text = self.playersTab[indexPath.row].name
        cell.labelPrenom.text = self.playersTab[indexPath.row].firstname
        cell.labelPoste.text = self.playersTab[indexPath.row].poste
        cell.photoProfil.image = UIImage(named: "soccer-player.png")!

        //cell = EffectifTableViewCell(style: .default, reuseIdentifier: "EffectifCell")
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "EffectifTableViewCell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewPlayersController = TableViewStatsPlayerController(nibName: "TableViewStatsPlayerController", bundle: nil)
        self.navigationController?.pushViewController(tableViewPlayersController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.playersTab.removeAll()
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayer))
        print(UserDefaults.standard.integer(forKey: "team"))
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getPlayerByTeam(id: idTeam) { (players) in
            for player in players{
                self.playersTab.append(player)
                self.tableViewEffectif.reloadData()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func addPlayer(){
        let playerCreate = PlayerCreateViewController(nibName: "PlayerCreateViewController", bundle: nil)
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
