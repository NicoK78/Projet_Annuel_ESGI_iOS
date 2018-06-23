//
//  EffectifViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class EffectifViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, EffectifDelegate, PlayerDeployDelegate  {
    func deploy(cell: PlayerDeployTableViewCell) {
        showOrHide(cell: cell)
    }
    
    
    func deploy(cell: TableViewCellEffectif) {
        showOrHide(cell: cell)
    }
    
    func showOrHide(cell: UITableViewCell) {
        let indexPath = tableViewEffectif.indexPath(for: cell)
        print("## \(indexPath!.row)")
        
        let tmp: IndexPath
        //        let row = sender.tag
        if selectedPath == indexPath {
            selectedPath = nil
        } else {
            if selectedPath != nil {
                tmp = selectedPath!
                selectedPath = indexPath
                
                tableViewEffectif.reloadRows(at: [tmp], with: UITableViewRowAnimation.none)
            } else {
                selectedPath = indexPath
            }
        }
        tableViewEffectif.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.none)
    }
    
    
    @IBOutlet var tableViewEffectif: UITableView!
    
    var selectedPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        // Do any additional setup after loading the view.
        
        self.tableViewEffectif.dataSource = self
        self.tableViewEffectif.delegate = self
        
        self.tableViewEffectif.register(UINib(nibName:"TableViewCellEffectif",bundle:nil), forCellReuseIdentifier: "EffectifCell")
        self.tableViewEffectif.register(UINib(nibName:"PlayerDeployTableViewCell",bundle:nil), forCellReuseIdentifier: "EffectifDeployCell")
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        print(indexPath.row)
        if selectedPath == indexPath {
            cell = tableView.dequeueReusableCell(withIdentifier: "EffectifDeployCell" ,for: indexPath)
            if let accessoryCell = cell as? PlayerDeployTableViewCell {
                accessoryCell.labelName.text = "VIADENOU Selom"
                accessoryCell.labelDate.text = "01/01/1994"
                accessoryCell.labelPost.text = "Attaquant (Zebi)"
                accessoryCell.photoProfile.image = UIImage(named: "soccer-player.png")!
                
                accessoryCell.delegate = self
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "EffectifCell" ,for: indexPath)
            if let accessoryCell = cell as? TableViewCellEffectif{
                accessoryCell.labelNom.text = "VIADENOU Selom"
                accessoryCell.labelPrenom.text = "01/01/1994"
                accessoryCell.labelPoste.text = "Attaquant (askip)"
                accessoryCell.photoProfil.image = UIImage(named: "soccer-player.png")!
                accessoryCell.btnDeploy.tag = indexPath.row
                
                accessoryCell.delegate = self
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedPath == indexPath {
            return 220
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayer))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func addPlayer(){
        let playerCreate = PlayerCreateViewController(nibName: "PlayerCreateViewController", bundle: nil)
        self.navigationController?.pushViewController(playerCreate, animated: true)
    }

}
