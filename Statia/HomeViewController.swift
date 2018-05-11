//
//  HomeViewController.swift
//  Statia
//
//  Created by Nico on 02/05/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBAction func connection(_ sender: UIButton) {
        let tableViewPlayersController = TableViewPlayersController(nibName: "TableViewPlayersController", bundle: nil)
        self.navigationController?.pushViewController(tableViewPlayersController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.backgroundColor = UIColor.gray.cgColor
        
        self.view.addBackground()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        
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

}

extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background_blue.jpg")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
}
