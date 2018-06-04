//
//  TableViewPlayersController.swift
//  Statia
//
//  Created by Nico on 08/05/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TableViewPlayersController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName:"TableViewCellPlayer",bundle:nil), forCellReuseIdentifier: "reuseCellIdentifier")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellIdentifier", for: indexPath)
        if let accessoryCell = cell as? TableViewCellPlayer {
            if indexPath.item % 2 == 0 {
                accessoryCell.backgroundColor = UIColor.lightGray
            }
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
        return cell
    }
    
    func showAndHideInfoPlayer() {
        print("TADAM")
    }
}
