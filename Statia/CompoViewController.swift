//
//  CompoViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 14/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CompoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var compoArray = [Composition]()
    var composDefaut = [Composition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.compoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel?.text = "\(self.compoArray[indexPath.row].team.name!) : \(self.compoArray[indexPath.row].name!)"
        
        var txt = UILabel()
        txt.text = "Selom"
        
        cell.contentView.addSubview(txt)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var idTeam = UserDefaults.standard.integer(forKey: "team")
        
        var compo = self.compoArray[indexPath.row]
        let compoController = CompositionViewController()
        compoController.compo = compo
        self.navigationController?.pushViewController(compoController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            Alamoquest.deleteCompo(compo: self.compoArray[indexPath.row], completionHandler: { (response) in
                self.compoArray.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
        }
        
        return [delete]
    }
    
    @objc func createCompo(){
        let alert = UIAlertController(title: "\n\n\n\n\n\n", message: "Composition par défaut", preferredStyle: .actionSheet)
        
        var margin:CGFloat = 10.0

        let rect = CGRect(x: margin, y: margin, width: alert.view.bounds.size.width - margin * 4.0, height: 100.0)
        let customView = UIView(frame: rect)
        
        customView.backgroundColor = UIColor.clear
        
        for (index, compo) in self.composDefaut.enumerated() {
            print("INDEX - \(index)")
            let buttonTest = UIButton(frame: CGRect(x: margin + CGFloat(10.0 + Double.init(index * 75)), y: margin, width: 70, height: 30))
            buttonTest.backgroundColor = UIColor.clear
            buttonTest.setTitleColor(UIColor.darkText, for: .normal)
            buttonTest.tag = compo.id
            buttonTest.setTitle(compo.name, for: .normal)
            buttonTest.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            customView.addSubview(buttonTest)
        }

        
        alert.view.addSubview(customView)

        alert.addAction(UIAlertAction(title: "Creer une nouvelle composition", style: .default, handler: newCompo))
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @objc func buttonAction(sender: UIButton!){
        
        self.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Choisir le \((sender.titleLabel?.text)!)", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { action in
            let alert = UIAlertController(title: "Nouvelle composition", message:nil, preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Nom de la composition"
                textField.text = "\((sender.titleLabel?.text)!)"
            }
            
            alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: {action in
                var idTeam = UserDefaults.standard.integer(forKey: "team")
                
                var compo = Composition()
                let team = Team()
                team.id = idTeam
                compo.team = team
                let txt = alert.textFields![0] as! UITextField
                let create = CompositionViewController()
                compo.name = txt.text!
                
                print(compo.toJsonCreate())
                Alamoquest.postComposition(compo: compo) { (composition) in
                    print("Sucess : \(compo.toJsonCreate())")
                    create.compo = composition
                    create.mode = sender.tag
                    if (composition.name == ""){
                        let alert = UIAlertController(title: "Attention", message:"Changer le nom de la composition.", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    self.navigationController?.pushViewController(create, animated: true)
                }
                
                
            }))
            
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Annuler", style: .default, handler: {action in
            self.dismiss(animated: true, completion: nil)
            self.createCompo()
            
            
        }))
        
        self.present(alert, animated: true)
    }
    
    func newCompo(sender: UIAlertAction){
        let alert = UIAlertController(title: "Nouvelle composition", message:nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nom de la composition"
        }
        
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: {action in
            var idTeam = UserDefaults.standard.integer(forKey: "team")

            var compo = Composition()
            let team = Team()
            team.id = idTeam
            compo.team = team

            let txt = alert.textFields![0] as! UITextField
            let create = CompositionViewController()
            compo.name = txt.text!

            print(compo.toJsonCreate())
            Alamoquest.postComposition(compo: compo) { (compo) in
                print("Sucess : \(compo.toJsonCreate())")
                create.compo = compo
                self.navigationController?.pushViewController(create, animated: true)
            }


        }))
        
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createCompo))
        self.compoArray.removeAll()
        self.composDefaut.removeAll()
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getCompoDefault { (compos) in
            for compo in compos {
                self.composDefaut.append(compo)
//                self.compoArray.append(compo)
            }
            Alamoquest.getCompoByTeam(idteam: idTeam) { (compos) in
                for compo in compos {
                    self.compoArray.append(compo)
                }
                self.tableView.reloadData()
            }
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
