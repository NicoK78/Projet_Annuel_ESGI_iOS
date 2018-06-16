//
//  CalendrierViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 15/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CalendrierViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCalendrier))
    }
    
    @objc private func addCalendrier(){
        let calendrierCreate = CalendrierCreateViewController(nibName: "CalendrierCreateViewController", bundle: nil)
        self.navigationController?.pushViewController(calendrierCreate, animated: true)
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
