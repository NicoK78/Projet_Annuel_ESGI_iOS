//
//  TableViewPlayersController.swift
//  Statia
//
//  Created by Nico on 08/05/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TableViewPlayersController: UIViewController, UITableViewDataSource , UITableViewDelegate {
//    typealias Stat = (string,int,)
    @IBOutlet var tableView: UITableView!
    
    var selectedPath: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName:"TableViewCellPlayer",bundle:nil), forCellReuseIdentifier: "reuseCellIdentifier")
        self.tableView.register(UINib(nibName:"PlayerDeployTableViewCell",bundle:nil), forCellReuseIdentifier: "playerDeployCellIdentifier")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        if selectedPath == indexPath {
            cell = tableView.dequeueReusableCell(withIdentifier: "playerDeployCellIdentifier", for: indexPath)
            if let accessoryCell = cell as? PlayerDeployTableViewCell {
                if indexPath.item % 2 == 0 {
                    accessoryCell.backgroundColor = UIColor.lightGray
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellIdentifier", for: indexPath)
            if let accessoryCell = cell as? TableViewCellPlayer {
                if indexPath.item % 2 == 0 {
                    accessoryCell.backgroundColor = UIColor.lightGray
                }

            //accessoryCell.showAndHide.actio
//            accessoryCell.showAndHide.titleLabel?.text = "N° \(indexPath)"
//            accessoryCell.showAndHide.addTarget(self, action: "showAndHideInfoPlayer:", for: .touchUpInside)

//            accessoryCell.label.text = self.todos[indexPath.item].title
//            if (self.todos[indexPath.item].tasks?.count)! <= 0 {
//                accessoryCell.labelSousTitre.text = "Done"
//            }else{
//                let aTask: Task = self.todos[indexPath.item].tasks?.allObjects[0] as! Task
//                accessoryCell.labelSousTitre.text = aTask.name
//            }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewPlayersController = TableViewStatsPlayerController(nibName: "TableViewStatsPlayerController", bundle: nil)
        self.navigationController?.pushViewController(tableViewPlayersController, animated: true)
        
//        let tmp: IndexPath
//        if selectedPath == indexPath {
//            selectedPath = nil
//        } else {
//            if selectedPath != nil {
//                tmp = selectedPath!
//                selectedPath = indexPath
//
//                tableView.reloadRows(at: [tmp], with: UITableViewRowAnimation.none)
//            } else {
//                selectedPath = indexPath
//            }
//        }
//        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedPath == indexPath {
            return 150
        } else {
            return 98
        }
    }
    
    func showAndHideInfoPlayer() {
        print("TADAM")
    }
}
