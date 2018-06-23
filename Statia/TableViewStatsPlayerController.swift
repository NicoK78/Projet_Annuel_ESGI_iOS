//
//  TableViewStatsPlayerController.swift
//  Statia
//
//  Created by Nico on 10/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TableViewStatsPlayerController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModifyInfosDelegate, StatsInfosDelegate {
    func modifyInfos(cell: ModifyInfoPlayerTableViewCell) {
        print("ModifyInfos")
        modifyCells(cell: cell)
    }
    
    func modifyInfos(cell: StatsInfoPlayerTableViewCell) {
        print("StatsInfos")
        modifyCells(cell: cell)
    }
    
    func modifyCells(cell: UITableViewCell) {
//        let indexPath = tableView.indexPath(for: cell)
        let indexPath = tableView.indexPathsForVisibleRows
        isModifying = !isModifying
        tableView.reloadRows(at: indexPath!, with: UITableViewRowAnimation.none)
        
    }
    

    @IBOutlet var tableView: UITableView!
    
    var isModifying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "StatsInfoPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "statsInfoIdentifier")
        self.tableView.register(UINib(nibName: "ModifyInfoPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "modifyInfoIdentifier")
        self.tableView.register(UINib(nibName: "ResponsibleTableViewCell", bundle: nil), forCellReuseIdentifier: "responsibleIdentifier")
        self.tableView.register(UINib(nibName: "ModifyResponsibleTableViewCell", bundle: nil), forCellReuseIdentifier: "modifyResponsibleIdentifier")
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
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.item {
        case 0:
            if(!isModifying) {
                cell = tableView.dequeueReusableCell(withIdentifier: "statsInfoIdentifier", for: indexPath)
                if let accessoryCell = cell as? StatsInfoPlayerTableViewCell {
                    accessoryCell.delegate = self
                }
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "modifyInfoIdentifier", for: indexPath)
                if let accessoryCell = cell as? ModifyInfoPlayerTableViewCell {
                    accessoryCell.delegate = self
                }
            }
        case 1:
            if(!isModifying) {
                cell = tableView.dequeueReusableCell(withIdentifier: "responsibleIdentifier", for: indexPath)
                if let accessoryCell = cell as? ResponsibleTableViewCell {
                    
                }
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "modifyResponsibleIdentifier", for: indexPath)
                if let accessoryCell = cell as? ModifyResponsibleTableViewCell {
                    
                }
            }
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "playTimeIdentifier", for: indexPath)
            if let accessoryCell = cell as? PlayTimeTableViewCell {
                
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "seasonResultsIdentifier", for: indexPath)
            if let accessoryCell = cell as? SeasonResultsTableViewCell {
                
            }
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "butsIdentifier", for: indexPath)
            if let accessoryCell = cell as? ButsTableViewCell {
                
            }
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "lastPassIdentifier", for: indexPath)
            if let accessoryCell = cell as? LastPassTableViewCell {
                
            }
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "cardsIdentifier", for: indexPath)
            if let accessoryCell = cell as? CardsTableViewCell {
                
            }
        case 7:
            cell = tableView.dequeueReusableCell(withIdentifier: "goalIdentifier", for: indexPath)
            if let accessoryCell = cell as? GoalTableViewCell {
                
            }
        case 8:
            cell = tableView.dequeueReusableCell(withIdentifier: "healthIdentifier", for: indexPath)
            if let accessoryCell = cell as? HealthTableViewCell {
                
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
            if(!isModifying) {
                return 120
            } else {
                return 300
            }
        case 1:
            if(!isModifying) {
                return 110
            } else {
                return 153
            }
        case 2:
            return 60
        case 3:
            return 125
        case 4:
            return 120
        case 5:
            return 120
        case 6:
            return 280
        case 7:
            return 280
        case 8:
            return 150
        default:
            return 60
        }
    }

}
