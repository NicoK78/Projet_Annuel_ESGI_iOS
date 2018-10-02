//
//  HomeViewController.swift
//  Statia
//
//  Created by Nico on 02/05/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var button: UIButton!
    
    @IBOutlet var usernameTxt: UITextField!
    
    @IBOutlet var passwordTxt: UITextField!
    /*@IBAction func connection(_ sender: UIButton) {
        let tableViewPlayersController = TableViewPlayersController(nibName: "TableViewPlayersController", bundle: nil)
        let homeView = AppHomeViewController(nibName: "AppHomeViewController", bundle: nil)
        self.navigationController?.pushViewController(homeView, animated: true)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let margins = view.layoutMarginsGuide
        // Do any additional setup after loading the view.
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.backgroundColor = UIColor.gray.cgColor
        button.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.view.addBackground()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func login(_ sender: Any) {
        /*UserDefaults.standard.set(0, forKey: "team")
        let tableViewPlayersController = TableViewPlayersController(nibName: "TableViewPlayersController", bundle: nil)
        let homeView = AppHomeViewController(nibName: "AppHomeViewController", bundle: nil)
        self.navigationController?.pushViewController(homeView, animated: true)
        return*/
        if (usernameTxt.text == "" && passwordTxt.text == ""){
            let username = usernameTxt.text
            let password = passwordTxt.text
            
            let parameter: Parameters = [
                "username":"viadenouselom@gmail.com",
                "password":"Jogabonito29&"
            ]
            
//            let parameter: Parameters = [
//                "username":username ?? "",
//                "password":password ?? ""
//            ]
            
            Alamoquest.login(parameter: parameter, completionHandler: { (json) in
                print("JSON : \(json)")
                if (json == false){
                    let alert = UIAlertController(title: "Attention", message: "Identifiant ou mot de passe incorect", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }else{
                    UserDefaults.standard.set(0, forKey: "team")
                    let tableViewPlayersController = TableViewPlayersController(nibName: "TableViewPlayersController", bundle: nil)
                    let homeView = AppHomeViewController(nibName: "AppHomeViewController", bundle: nil)
                    self.navigationController?.pushViewController(homeView, animated: true)
                }
            })
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
