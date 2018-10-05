//
//  PlayerCreateV2ViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 11/08/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class PlayerCreateV2ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UIPickerViewDelegate , UIPickerViewDataSource {
    

    
    @IBOutlet var tableView: UITableView!
    let datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var textTemp = UITextField()
    var nameTemp = ""
    var nameFull = ""
    var labelTitre = UILabel()
    var picker = UIPickerView()
    var posteArray = [Poste]()
    var player = Player()
    var user = Users()
    var name = ""
    var firstname = ""
    var birthday = ""
    var email = ""
    var portable = ""
    var piedFort = ""
    var poste = ""
    var mode = 0
    var foot = ["Droit","Gauche"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName:"PlayerCreateTableViewCell",bundle:nil), forCellReuseIdentifier: "pCreate")
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCreatePLayer))
        
        picker.backgroundColor = UIColor.white
        picker.delegate = self
        picker.dataSource = self
        
        
        self.datePicker.timeZone = TimeZone(abbreviation: "UTC")
        self.datePicker.locale = Locale(identifier: "FR-fr")
        self.datePicker.datePickerMode = .date
        self.datePicker.addTarget(self, action: #selector(pickerBirthdayChange(sender:)), for: .valueChanged)
        
        self.toolBar.barStyle = .default
        self.toolBar.isTranslucent = true
        self.toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        self.toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        Alamoquest.getPoste { (postes) in
            for poste in postes {
                self.posteArray.append(poste)
            }
            self.picker.reloadComponent(0)
            
        }
        
        
    }
    
    @objc func donePicker(sender: UIBarButtonItem){
        //self.textTemp.resignFirstResponder()
        
        var indexPath = IndexPath(row: 2, section: 0)
        var cell = self.tableView.cellForRow(at: indexPath)?.viewWithTag(2) as! UITextField
        cell.resignFirstResponder()
        
        indexPath = IndexPath(row: 6, section: 0)
        cell = self.tableView.cellForRow(at: indexPath)?.viewWithTag(6) as! UITextField
        cell.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row < 7){
            let cell = tableView.dequeueReusableCell(withIdentifier: "pCreate" ,for: indexPath) as! PlayerCreateTableViewCell
            
            cell.selectionStyle = .none
            
            switch (indexPath.row) {
            case 0:
                cell.textField.placeholder = "Nom"
                cell.textField.tag = 0
                cell.textField.addTarget(self, action: #selector(changeInfo(sender:)), for: UIControlEvents.editingChanged)
                
            case 1:
                cell.textField.placeholder = "Prénom"
                cell.textField.tag = 1
                cell.textField.addTarget(self, action: #selector(changeInfo(sender:)), for: .allEditingEvents)
            case 2:
                cell.textField.placeholder = "Date de naissance"
                cell.textField.inputView = self.datePicker
                cell.textField.inputAccessoryView = self.toolBar
                cell.textField.tag = 2
                
                if (self.mode == 1){
                    let formater = DateFormatter()

                    formater.dateFormat = "yyyy-MM-dd"
                    formater.timeZone = TimeZone(abbreviation: "GMT")
                    
                    var dateTemp = formater.date(from: self.player.birhtDate ?? "")
                    
                    self.datePicker.date = dateTemp ?? Date()
                    
                }
                self.datePicker.maximumDate = Date()
                cell.textField.addTarget(self, action: #selector(showPicker(sender:)), for: .touchDown )
                self.textTemp = cell.textField
            case 3:
                cell.textField.placeholder = "email"
                cell.textField.tag = 3
            case 4:
                cell.textField.placeholder = "Portable"
                cell.textField.tag = 4
            case 5:
                cell.textField.placeholder = "Pied Fort"
                cell.textField.tag = 5
            case 6:
                cell.textField.placeholder = "Poste"
                cell.textField.inputView = self.picker
                cell.textField.inputAccessoryView = self.toolBar
                cell.textField.tag = 6
                cell.textField.addTarget(self, action: #selector(showPicker(sender:)), for: .touchDown)
                self.textTemp = cell.textField
            default:
                cell.textField.placeholder = ""
            }
            if(mode == 1){
                modifPlayer(cell: cell)
            }
            cell.textField.addTarget(self, action: #selector(resetColorTextField(sender:)), for: .editingChanged)
            cell.textField.addTarget(self, action: #selector(getValueTextField(sender:)), for: .editingDidEnd)
            return cell
        }else{
            let cell = UITableViewCell()
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    

    @IBAction func showPicker(sender: UITextField){
        
        sender.resignFirstResponder()
        if(sender.tag == 6){
            sender.text = "\((self.posteArray[0].role)!) \((self.posteArray[0].cote) ?? " ")"
        }
    }
    
    @objc func pickerBirthdayChange(sender: UIDatePicker){
        
        let formater = DateFormatter()
        
        formater.dateStyle = DateFormatter.Style.long
        
        formater.timeStyle = DateFormatter.Style.none
        
        formater.locale = Locale(identifier: "FR-fr")

        let indexPath = IndexPath(row: 2, section: 0)
        var cell = self.tableView.cellForRow(at: indexPath)?.viewWithTag(2) as! UITextField
        cell.text = formater.string(from: sender.date)
        //self.textTemp.text = formater.string(from: sender.date)
        
        self.labelTitre.text = self.nameFull + " " + "\(Date.getAgefromDate(birthDate: sender.date)) ans"
        
        //self.pickerBirthday.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Random Marabou"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textColor = UIColor.black
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        headerText.tag = 2
        headerText.text = "\(self.player.user.name ?? "") \(self.player.user.firstname ?? "")"
        self.labelTitre = headerText
        return headerText
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.posteArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  "\((self.posteArray[row].role)!) \((self.posteArray[row].cote) ?? " ")"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = IndexPath(row: 6, section: 0)
        var cell = self.tableView.cellForRow(at: indexPath)?.viewWithTag(6) as! UITextField
        cell.text = "\((self.posteArray[row].role)!) \((self.posteArray[row].cote) ?? " ")"
    }
    
    
    @objc func changeInfo(sender: UITextField){

        if (sender.tag == 1){
            self.tableView.headerView(forSection: 0)?.textLabel?.text = nameTemp + " " + sender.text!
            self.labelTitre.text =  nameTemp + " " + sender.text!
            self.nameFull =  nameTemp + " " + sender.text!
        }else{
            self.tableView.headerView(forSection: 0)?.textLabel?.text = sender.text
            self.labelTitre.text = sender.text!
            nameTemp = sender.text!
        }
        
    }
    
    @objc func resetColorTextField(sender: UITextField){
        var cell = sender.superview?.superview as! PlayerCreateTableViewCell
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func doneCreatePLayer(){
        //checkTextfield()
        formToPlayer()
    }
    
    @objc func getValueTextField(sender: UITextField){
        print("\(sender.tag)")
        let alert = UIAlertController(title: "Attention", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let cell = self.tableView.cellForRow(at: indexPath) as! PlayerCreateTableViewCell
        if (sender.text == ""){
//            cell.layer.borderWidth = 2.0
//            cell.layer.borderColor = UIColor.red.cgColor
            alert.message = "\(((cell.textField.placeholder)!)) manquant"
            self.present(alert, animated: true)
            return
        }
        switch(sender.tag){
        case 0 :
            self.player.user.name = cell.textField.text
            break
        case 1:
            self.player.user.firstname = cell.textField.text
            break
        case 2:
            //self.player.birhtDate = cell.textField.text
            break
        case 3:
            self.player.user.email = cell.textField.text
            break
        case 4:
            self.player.mobile = cell.textField.text
            break
        case 5:
            self.player.strongFoot = cell.textField.text
            break
        case 6:
            self.player.poste = cell.textField.text
        default:
            
            break;
        }
    }
    
    func checkTextfield(){
        let alert = UIAlertController(title: "Attention", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        
        var indexPath = IndexPath(row: 0, section: 0)
        for i in 0...6 {
            indexPath.row = i
//            var cell = self.tableView.cellForRow(at: indexPath) as! PlayerCreateTableViewCell
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "pCreate", for: indexPath) as! PlayerCreateTableViewCell
            if(cell.textField.text == "") {
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.red.cgColor
                alert.message = "\(((cell.textField.placeholder)!)) manquant"
                self.present(alert, animated: true)
                return
            }
        }
    }
    
    func formToPlayer(){
        

        for i in 0...6 {
            var indexPath = IndexPath(row: i, section: 0)
            var cell = self.tableView.cellForRow(at: indexPath) as! PlayerCreateTableViewCell

            switch(i){
                case 0 :
                    self.player.user.name = cell.textField.text
                    break
                case 1:
                    self.player.user.firstname = cell.textField.text
                    break
                case 2:
                    let formater = DateFormatter()
                    
                    formater.dateStyle = DateFormatter.Style.long
                    
                    formater.timeStyle = DateFormatter.Style.none
                    
                    formater.locale = Locale(identifier: "FR-fr")
                    
                    let dateTemp = formater.date(from: cell.textField.text ?? "")!
                    
                    formater.dateFormat = "yyyy-MM-dd"
                    
                    self.player.birhtDate = formater.string(from: dateTemp)
                    break
                case 3:
                    self.player.user.email = cell.textField.text
                    break
                case 4:
                    self.player.mobile = cell.textField.text
                    break
                case 5:
                    self.player.strongFoot = cell.textField.text
                    break
                case 6:
                    self.player.poste = cell.textField.text
                default:

                    break;
                }
        }
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        self.player.team.id = idTeam
        print(self.mode)
        if (self.mode == 0){
            print(self.player.toJsonV2())
            Alamoquest.postPlayer(player: self.player) { (player) in
                if (player.poste ?? "" == "duplicata"){
                    let alert = UIAlertController(title: "Attention", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    alert.message = "l'email : \((player.user.email)!) est déjà existant"
                    self.present(alert,animated: true)
                    return
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            }
        }else{
            print(self.player.toJSONUpdate().dictionaryObject)
            Alamoquest.putPlayer(player: self.player,id: self.player.id) { (player) in
                print(player)
                self.navigationController?.popViewController(animated: true)
            }
        }


    }
    
    
    func modifPlayer(cell : PlayerCreateTableViewCell){
            print("Modification")
            print("\(self.player.toJSON())")
        
            switch(cell.textField.tag){
                case 0 :
                    cell.textField.text = self.player.user.name
                    break
                case 1:
                    cell.textField.text = self.player.user.firstname
                    break
                case 2:
                    let formater = DateFormatter()
                    formater.locale = Locale(identifier: "FR-fr")
                    formater.dateFormat = "yyyy-MM-dd"
                    
                    let dateTemp = formater.date(from: self.player.birhtDate ?? "")
                    
                    formater.dateStyle = DateFormatter.Style.long
                    formater.timeStyle = DateFormatter.Style.none
                
                    cell.textField.text = formater.string(from: dateTemp ?? Date())
                    //self.player.birhtDate = cell.textField.text
                    break
                case 3:
                    cell.textField.text = self.player.user.email
                    break
                case 4:
                    cell.textField.text = self.player.mobile
                    break
                case 5:
                    cell.textField.text = self.player.strongFoot
                    break
                case 6:
                    cell.textField.text = self.player.poste
//                    self.mode = 0
                    break
                default:
                    
                    break;
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

