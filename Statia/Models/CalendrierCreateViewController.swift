//
//  CalendrierCreateViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 16/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import ViewAnimator

class CalendrierCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var switchLieu: UISwitch!
    @IBOutlet var btnChampionnat: UIButton!
    @IBOutlet var btnCoupe: UIButton!
    @IBOutlet var btnAmical: UIButton!
    @IBOutlet var versusTeamTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var labelDomicile: UILabel!
    
    @IBOutlet var labelExterieur: UILabel!
    @IBOutlet var txtFDay: UITextField!
    @IBOutlet var lblDay: UILabel!
    
    var teamsTable = [Team]()
    var teamVs = Team()
    var idCompet = 2
    
    var matchUpdate = Match()
    var mode = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)

        

        initButton()
        initLabel()
        self.btnChampionnat.addTarget(self, action: #selector(setLieu), for: UIControlEvents.touchUpInside)
        self.btnChampionnat.tag = 1
        self.btnCoupe.addTarget(self, action: #selector(setLieu), for: UIControlEvents.touchUpInside)
        self.btnCoupe.tag = 0
        self.btnAmical.addTarget(self, action: #selector(setLieu), for: UIControlEvents.touchUpInside)
        self.btnAmical.tag = 2

        //self.pickerView.delegate = self
        //self.pickerView.dataSource = self
        self.pickerView.backgroundColor = UIColor.white
        self.pickerView.isHidden = true
        self.datePicker.isHidden = true
        self.datePicker.backgroundColor = UIColor.white
        self.pickerView.showsSelectionIndicator = true
        
        
        
        self.versusTeamTxt.tag = 1
        self.dateTxt.tag = 2
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCreateTeam))
        
        if (self.mode == 1 || self.mode == 2 ){
            initMatchUpdate(match: self.matchUpdate)
        }
        
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let idLeague = UserDefaults.standard.integer(forKey: "idleague")
        Alamoquest.getTeamByLeague(idLeague: idLeague) { (teams) in
            print(teams)
            for team in teams {
                self.teamsTable.append(team)
            }
            self.pickerView.reloadAllComponents()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.teamsTable.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.teamsTable[row].club.name!) : \(self.teamsTable[row].name!)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.teamVs = self.teamsTable[row]
        self.versusTeamTxt.text = "\(self.teamsTable[row].club.name!) : \(self.teamsTable[row].name!)"
        //self.pickerView.isHidden = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    
    @IBAction func setLieu(sender: UIButton!){
        let btnSender: UIButton = sender
        if(btnSender.tag == 0){
            btnCoupe.backgroundColor = UIColor.lightGray
            btnChampionnat.backgroundColor = UIColor.clear
            btnAmical.backgroundColor = UIColor.clear
            self.idCompet = 2
            self.txtFDay.isHidden = true
            self.lblDay.isHidden = true
        }else if(btnSender.tag == 1){
            btnCoupe.backgroundColor = UIColor.clear
            btnChampionnat.backgroundColor = UIColor.lightGray
            btnAmical.backgroundColor = UIColor.clear
            self.idCompet = 3
            self.txtFDay.isHidden = false
            self.lblDay.isHidden = false
        }else if(btnSender.tag == 2){
            btnCoupe.backgroundColor = UIColor.clear
            btnChampionnat.backgroundColor = UIColor.clear
            btnAmical.backgroundColor = UIColor.lightGray
            self.idCompet = 1
            self.txtFDay.isHidden = true
            self.lblDay.isHidden = true
        }
    }
    
    @IBAction func changeSwitch(sender: UITapGestureRecognizer!){
        let label = sender.view as! UILabel
        let zoom = AnimationType.zoom(scale: 0.5)
        if(label.tag == 0){
            self.switchLieu.setOn(false, animated: true)
            self.labelDomicile.animate(animations: [zoom])
        }else if(label.tag == 1){
            self.switchLieu.setOn(true, animated: true)
            self.labelExterieur.animate(animations: [zoom])
        }
    }
    
    func showPicker(){
        self.versusTeamTxt.resignFirstResponder()
        self.dateTxt.resignFirstResponder()
       // self.pickerView.isHidden = false
        //self.datePicker.isHidden =  true
    }
    
    func showDatePicker(){
        self.datePicker.isHidden = false
        self.pickerView.isHidden = true
    }
    
    func hidePicker(){
        self.pickerView.isHidden = true
        
    }
    
    func hideDatePicker(){
        self.datePicker.isHidden = true
    }
    
    @objc func hideAll(){
        hidePicker()
        hideDatePicker()
    }
    
    @IBAction func endEditTeam(_ sender: Any) {
        let txt = sender as! UITextField
        if (txt.tag == 1){
            hidePicker()
        }else if(txt.tag == 2){
            hideDatePicker()
        }

    }
    @IBAction func editVersusTeam(_ sender: Any) {
        let txt = sender as! UITextField
        
        let picker: UIPickerView
        picker = UIPickerView()
        picker.backgroundColor = UIColor.white
        picker.delegate = self
        picker.dataSource = self
        
        let datePicker = UIDatePicker()
        datePicker.timeZone = TimeZone(abbreviation: "UTC")
        datePicker.locale = Locale(identifier: "FR-fr")
        datePicker.addTarget(self, action: #selector(pickerBirthdayChange(sender:)), for: .valueChanged)
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        
        if (txt.tag == 1){
            txt.inputView = picker
            txt.inputAccessoryView = toolBar
            txt.resignFirstResponder()
        }else if(txt.tag == 2){
            txt.inputView = datePicker
            txt.inputAccessoryView = toolBar
            txt.resignFirstResponder()
            //showDatePicker()
        }

    }
    
    func initButton(){
        
        switchLieu.setOn(false, animated: false)
        if(self.mode == 0){
            btnCoupe.backgroundColor = UIColor.lightGray
            self.idCompet = 2
        }

        
        
        //btnChampionnat.layer.cornerRadius = 15
        btnChampionnat.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btnChampionnat.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //btnCoupe.layer.cornerRadius = 15
       // btnCoupe.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        //btnCoupe.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //btnAmical.layer.cornerRadius = 15
       // btnAmical.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
       // btnAmical.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func initLabel(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(CalendrierCreateViewController.changeSwitch))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(CalendrierCreateViewController.changeSwitch))
        labelDomicile.tag = 0
        labelDomicile.isUserInteractionEnabled = true
        labelExterieur.tag = 1
        labelExterieur.isUserInteractionEnabled = true
        
        labelDomicile.addGestureRecognizer(tap)
        labelExterieur.addGestureRecognizer(tap2)
    }
    
    
    func initMatchUpdate(match:Match){
        let idteam = UserDefaults.standard.integer(forKey: "team")
        if(match.home.id == idteam){
            self.versusTeamTxt.text = "\(match.away.club.name!) : \(match.away.name!)"
            self.switchLieu.isOn = false
            self.teamVs = match.away
        }else{
            self.versusTeamTxt.text = "\(match.home.club.name!) : \(match.home.name!)"
            self.switchLieu.isOn = true
            self.teamVs = match.home
        }
        
        
        if (self.mode == 1){
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            formater.timeZone = TimeZone(abbreviation: "UTC")
            formater.locale = Locale(identifier: "FR-fr")
            
            let dateMatch = formater.date(from: match.date)
            
            formater.dateStyle = DateFormatter.Style.long
            
            formater.timeStyle = DateFormatter.Style.short
            
            self.dateTxt.text = formater.string(from: dateMatch!)
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(updateMatch))
        }
        

        switch match.tournament.id {
            
        case 1:
            self.btnAmical.backgroundColor = UIColor.lightGray
            self.idCompet = 1
        case 2:
            self.btnCoupe.backgroundColor = UIColor.lightGray
            self.idCompet = 2

        case 3:
            self.btnChampionnat.backgroundColor = UIColor.lightGray
            self.idCompet = 3
        case .none:
            self.btnChampionnat.backgroundColor = UIColor.lightGray
            self.idCompet = 3
        case .some(_):
            self.btnChampionnat.backgroundColor = UIColor.lightGray
            self.idCompet = 3
        }
        

        
        //if (self.mode)
    }
    
    @objc func updateMatch(){
        var match = Match()
        match.id = self.matchUpdate.id
        match.tournament = Competition()
        match.tournament.id = self.idCompet
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        if(self.switchLieu.isOn){
            match.home = teamVs
            match.away = Team.getTeam(teams: self.teamsTable, id: idTeam)
        }else{
            match.away = teamVs
            match.home = Team.getTeam(teams: self.teamsTable, id: idTeam)
        }
        
        let formater = DateFormatter()
        
        
        formater.dateStyle = DateFormatter.Style.long
        formater.timeStyle = DateFormatter.Style.short
        
        formater.locale = Locale(identifier: "FR-fr")
        let dateMatch = formater.date(from: self.dateTxt.text!)
        
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = formater.string(from: dateMatch!)

        match.date = dateString
        
        Alamoquest.updateMatch(match: match) { (match) in
            print("SUCESS : \(match)")
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    @objc func pickerBirthdayChange(sender: UIDatePicker){
        
        let formater = DateFormatter()
        
        //formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        formater.dateStyle = DateFormatter.Style.long
        
        formater.timeStyle = DateFormatter.Style.short
        
        formater.locale = Locale(identifier: "FR-fr")
        
        dateTxt.text = formater.string(from: sender.date)
        
        //labelAge.text = "\(Date.getAgefromDate(birthDate: sender.date)) ans"
        
        //self.pickerBirthday.isHidden = true
    }
    
    
    @objc func donePicker(sender: UIBarButtonItem){
        self.versusTeamTxt.resignFirstResponder()
        self.dateTxt.resignFirstResponder()

    }
    
    func pickUp(textField: UITextField){
        
    }
    
    
    @objc func doneCreateTeam(){
        print("######## 1 ##########")
        if(dateTxt.text == "" && self.versusTeamTxt.text == ""){
            return
        }
        let idTeam = UserDefaults.standard.integer(forKey: "team")
        var match = Match()
        match.tournament = Competition()
        match.tournament.id = self.idCompet
        if(self.switchLieu.isOn){
            match.home = self.teamVs
            match.away = Team.getTeam(teams: self.teamsTable, id: idTeam)
        }else{
            match.away = self.teamVs
            match.home = Team.getTeam(teams: self.teamsTable, id: idTeam)
        }
        let formater = DateFormatter()
        
        
        formater.dateStyle = DateFormatter.Style.long
        formater.timeStyle = DateFormatter.Style.short
        
        formater.locale = Locale(identifier: "FR-fr")
        let dateMatch = formater.date(from: self.dateTxt.text!)

        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = formater.string(from: dateMatch!)
        
        print(dateString)
        print("######### 2 #########")
        match.date = dateString
        print(match.date!)
        print(match.home.name)
        print("######### 3 #########")
        var tt = match.toJsonCreate()
        print(tt)
        print("######### 4 #########")
        Alamoquest.postMatch(match: match) { (match) in
            print("SUCESS : \(match)")
            self.navigationController?.popViewController(animated: true)
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
