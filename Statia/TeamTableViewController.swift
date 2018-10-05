//
//  TeamTableViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 03/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import ViewAnimator

class TeamTableViewController: UITableViewController {
    
    var teamsTable = [Team]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "teamCell")
        
        Alamoquest.getTeam { (teams) in
            for team in teams{
                print(team)
                self.teamsTable.append(team)
                UserDefaults.standard.set(self.teamsTable[0].id, forKey: "team")
                UserDefaults.standard.set(self.teamsTable[0].league.id, forKey: "idleague")
                self.tableView.reloadData()
            }
        }
        self.tableView.backgroundColor = .clear
        print("\(UserDefaults.standard.integer(forKey: "profil"))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let barbutton = UIBarButtonItem(image: UIImage(named: "logout.png"), style: .done, target: self, action: #selector(Deconnect))
        self.tabBarController?.navigationItem.leftBarButtonItem = barbutton //UIBarButtonItem(title: "Deco", style: .done, target: self, action: #selector(Deconnect))
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
         let zoomAnimation = AnimationType.zoom(scale: 0.5)
         UIView.animate(views: self.tableView.visibleCells, animations: [zoomAnimation], duration: 0.3)
    }
    

    
    @objc func Deconnect(){
        self.navigationController?.popToRootViewController(animated: true)
       
    }
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.teamsTable.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell" ,for: indexPath) as! TeamTableViewCell
        
        cell.villeEquipe.text = self.teamsTable[indexPath.row].league.name
        cell.nomEquipe.text =  self.teamsTable[indexPath.row].name
        
        cell.backgroundColor = .clear//UIColor(red: 93/255, green: 176/255, blue: 213/255, alpha: 1.0)
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! TeamTableViewCell
        
        if cell != nil{
            let alert = UIAlertController(title: "Selection de l'équipe", message: "Vous avez selectionner \(cell.nomEquipe.text!).", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {action in
                print("ID TEAM : \(self.teamsTable[indexPath.row].id)")
                UserDefaults.standard.set(self.teamsTable[indexPath.row].id, forKey: "team")
                UserDefaults.standard.set(self.teamsTable[indexPath.row].league.id, forKey: "idleague")
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    
    
    
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
