//
//  AppHomeViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 29/05/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class AppHomeViewController: UITabBarController   {
    @IBOutlet var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        // Do any additional setup after loading the view.
        
        let nameClub = UserDefaults.standard.string(forKey: "nameclub")
        self.navigationItem.title = nameClub
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let team = TeamTableViewController()
        team.title = "First"
        team.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)
        
        
        let effectif = EffectifViewController()
        effectif.title = "Effectif"
        effectif.tabBarItem = UITabBarItem(title: "Effectif", image: nil, tag: 1)
        
        let calendrier = CalendrierViewController()
        calendrier.title = "Calendrier"
        calendrier.tabBarItem = UITabBarItem(title: "Calendrier", image: UIImage(named: "calendrier.png"), tag: 2)
        
        let composition = CompoViewController()
        composition.tabBarItem = UITabBarItem(title: "Composition", image: nil, tag: 3)
        
        let resultat = ResultatViewController()
        resultat.tabBarItem = UITabBarItem(title: "Resultat", image: nil, tag: 4)

        
        let controllers = [team,effectif,calendrier,composition,resultat]
        self.viewControllers = controllers
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool{
        return false
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
