//
//  PlayerCreateViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class PlayerCreateViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {
    @IBOutlet var labelPrenom: UITextField!
    @IBOutlet var labelNom: UITextField!
    @IBOutlet var birthdayLabel: UITextField!
    @IBOutlet var labelAge: UILabel!
    @IBOutlet var posteLabel: UITextField!
    @IBOutlet var portableLabel: UITextField!
    @IBOutlet var piedFortLabel: UITextField!
    
    @IBOutlet var emailLabel: UITextField!
    
    @IBOutlet var pickerBirthday: UIDatePicker!

        @IBOutlet var pickerPoste: UIPickerView!
        @IBOutlet var imgLogo: UIImageView!
    
    var posteArray = [Poste]()
    
    var player = Player()
    
    
    let footChoice = ["Droit", "Gauche"]
    override func viewDidLoad() {
        super.viewDidLoad()
       /* if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
                imgLogo.isHidden = false
            default:
                print("unknown")
            }
        }*/
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCreatePLayer))
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        self.pickerPoste.delegate = self
        self.pickerPoste.dataSource = self
        pickerBirthday.isHidden = true
        pickerPoste.isHidden = true
        pickerBirthday.addTarget(self, action: #selector(pickerBirthdayChange(sender:)), for: .valueChanged)
        //pickerBirthday.addTarget(self, action: #selector(hideDateBirth(<#Any#>)), for: .touchUpOutside)
        // Do any additional setup after loading the view.
        self.pickerPoste.backgroundColor = UIColor.white
        self.pickerBirthday.backgroundColor = UIColor.white
        
        Alamoquest.getPoste { (postes) in
            for poste in postes{
                print( "\(String(describing: poste.role)) : \(poste.cote ?? "")")
                self.posteArray.append(poste)
            }
            self.pickerPoste.reloadAllComponents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return posteArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: posteArray[row])
    }
    
    @objc func pickerBirthdayChange(sender: UIDatePicker){
        
        let formater = DateFormatter()
        
        formater.dateStyle = DateFormatter.Style.long
        
        formater.timeStyle = DateFormatter.Style.none
        
        formater.locale = Locale(identifier: "FR-fr")
        
        birthdayLabel.text = formater.string(from: sender.date)
        
        labelAge.text = "\(Date.getAgefromDate(birthDate: sender.date)) ans"
        
        //self.pickerBirthday.isHidden = true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.posteLabel.text = String(describing: self.posteArray[row])
        //self.pickerPoste.isHidden = true
    }
    
    @objc func doneCreatePLayer(){
        checkTextfield()
        formToPlayer()
        Alamoquest.postPlayer(player: self.player) { (player) in
            print(player)
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction @objc  func hideDateBirth(_ sender: Any) {
        pickerBirthday.isHidden = true
    }
    
    @IBAction func showPickerBirthday(_ sender:Any){
        pickerBirthday.isHidden = false
        pickerPoste.isHidden = true
    }
    
    
    @IBAction func showPickerPoste(_ sender: Any) {
        pickerPoste.isHidden = false
        pickerBirthday.isHidden = true
    }
    

    @IBAction func hidePickerPoste(_ sender: Any) {
        pickerPoste.isHidden = true
    }
    
    func checkTextfield(){
        let alert = UIAlertController(title: "Attention", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        
        
        if(labelPrenom.text == ""){
            alert.message = "Prénom manquant"
            self.present(alert, animated: true)
            return
        }
        if(labelNom.text == ""){
            alert.message = "Nom manquant"
            self.present(alert, animated: true)
            return
        }
        if(birthdayLabel.text == ""){
            alert.message = "Date de naissance manquante"
            self.present(alert, animated: true)
            return
        }
        if(posteLabel.text == ""){
            alert.message = "Poste manquant"
            self.present(alert, animated: true)
            return
        }
        if(piedFortLabel.text == ""){
            alert.message = "Pied fort manquant"
            self.present(alert, animated: true)
            return
        }
        if(portableLabel.text == ""){
            alert.message = "Portable manquant"
            self.present(alert, animated: true)
            return
        }
        if(emailLabel.text == ""){
            alert.message = "Email manquant"
            self.present(alert, animated: true)
            return
        }
    }
    
    func formToPlayer(){
        self.player.name = labelNom.text!
        self.player.firstname = labelPrenom.text!
        //birthdayLabel.text = self.player.b
        self.player.poste = posteLabel.text!
        self.player.strongFoot = piedFortLabel.text!
        self.player.mobile = portableLabel.text!
        self.player.email = emailLabel.text!
        
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        self.player.idTeam = idTeam
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

extension Date {
    static func getAgefromDate(birthDate: Date) -> Int {
        var currentdate = Date()
        var calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentdate)
        let age = ageComponents.year!
        
        return age
    }
}
