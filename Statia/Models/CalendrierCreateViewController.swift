//
//  CalendrierCreateViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 16/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CalendrierCreateViewController: UIViewController {

    @IBOutlet var switchLieu: UISwitch!
    @IBOutlet var btnChampionnat: UIButton!
    @IBOutlet var btnCoupe: UIButton!
    @IBOutlet var btnAmical: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)

        

        initButton()
        self.btnChampionnat.addTarget(self, action: #selector(setLieu), for: UIControlEvents.touchUpInside)
        self.btnChampionnat.tag = 1
        self.btnCoupe.addTarget(self, action: #selector(setLieu), for: UIControlEvents.touchUpInside)
        self.btnCoupe.tag = 0
        self.btnAmical.addTarget(self, action: #selector(setLieu), for: UIControlEvents.touchUpInside)
        self.btnAmical.tag = 2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setLieu(sender: UIButton!){
        let btnSender: UIButton = sender
        if(btnSender.tag == 0){
            btnCoupe.backgroundColor = UIColor.lightGray
            btnChampionnat.backgroundColor = UIColor.clear
            btnAmical.backgroundColor = UIColor.clear
        }else if(btnSender.tag == 1){
            btnCoupe.backgroundColor = UIColor.clear
            btnChampionnat.backgroundColor = UIColor.lightGray
            btnAmical.backgroundColor = UIColor.clear
        }else if(btnSender.tag == 2){
            btnCoupe.backgroundColor = UIColor.clear
            btnChampionnat.backgroundColor = UIColor.clear
            btnAmical.backgroundColor = UIColor.lightGray
        }
    }
    
    
    func initButton(){
        
        switchLieu.setOn(false, animated: false)
        btnChampionnat.backgroundColor = UIColor.lightGray
        
        
        btnChampionnat.layer.cornerRadius = 15
        btnChampionnat.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btnChampionnat.titleLabel?.adjustsFontSizeToFitWidth = true
        
        btnCoupe.layer.cornerRadius = 15
       // btnCoupe.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        //btnCoupe.titleLabel?.adjustsFontSizeToFitWidth = true
        
        btnAmical.layer.cornerRadius = 15
       // btnAmical.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
       // btnAmical.titleLabel?.adjustsFontSizeToFitWidth = true
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
