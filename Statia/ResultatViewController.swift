//
//  ResultatViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 12/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class ResultatViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    
    let choice = ["Amical","Championnat","Coupe"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.choice[indexPath.section]
        
        cell.backgroundColor = .clear//UIColor(red: 93/255, green: 176/255, blue: 213/255, alpha: 1.0)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                let resultat = ResultatSecondViewController()
                resultat.idCompetition = 1
                self.navigationController?.pushViewController(resultat, animated: true)
            case 1:
                let resultat = ResultatSecondViewController()
                resultat.idCompetition = 3
                self.navigationController?.pushViewController(resultat, animated: true)
            case 2:
                let resultat = ResultatSecondViewController()
                resultat.idCompetition = 2
                self.navigationController?.pushViewController(resultat, animated: true)
            default:
                return
        }
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
