//
//  CalendrierV2ViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 02/10/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CalendrierV2ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(UINib(nibName: "CalendrierV2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCalendar")
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCalendar", for: indexPath) as! CalendrierV2CollectionViewCell
        
        cell.labelType.text = "Championnat"
        
        return cell
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
