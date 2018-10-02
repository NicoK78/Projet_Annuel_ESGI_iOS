//
//  CompositionViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 17/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CompositionViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource  {

    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewTeam: UITableView!
    
    @IBOutlet var viewField: UIView!
    
    var textField = UITextField()
    var textFieldPoste = UITextField()
    var player : Player? = Player()
    var poste : Poste? = Poste()
    var compo = Composition()
    var mode = 0
    var compodetails = [CompositionDetails]()
    var playersArray = [Player]()
    var playerArrayPicker = [Player]()
    var posteArray = [Poste]()
    var playersArrayPlay = [CompositionDetails]()
    var playersArraySub = [CompositionDetails]()
    var pickerView = UIPickerView()
    override func viewDidLoad() {//compoCell
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
        

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isEditing = true
        //self.tableView.register(UINib(nibName:"TitreCompoTableViewCell",bundle:nil), forCellReuseIdentifier: "titreCompo")
        
        self.tableView.register(UINib(nibName:"CompoTableViewCell",bundle:nil), forCellReuseIdentifier: "compoCell")
        let btnItem = UIBarButtonItem(title: "Sauvegarder", style: .plain, target: self, action: #selector(saveCompositionDetail))
        self.navigationItem.rightBarButtonItem = btnItem
        
        //self.viewField.backgroundColor = UIColor(patternImage: UIImage(named: "field.png")!)
        //self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "field.png")!)
        
        // Do any additional setup after loading the view.
        print("\(self.compo.team.name) \(self.compo.name)")

        let idTeam = UserDefaults.standard.integer(forKey: "team")
        Alamoquest.getPlayerByTeam(id: idTeam) { (players) in
            for player in players {
                self.playersArray.append(player)
                self.playerArrayPicker.append(player)
            }
             self.tableView.reloadData()
        }
        
        Alamoquest.getPoste { (postes) in
            for poste in postes {
                self.posteArray.append(poste)
            }
        
        }
        if(self.mode != 0){
            Alamoquest.getComposDetailsByCompo(idcompo: self.mode) { (composDArray) in
                self.compodetails.removeAll()
                self.playersArrayPlay.removeAll()
                for compoD in composDArray{
                    compoD.composition = self.compo
                    self.compodetails.append(compoD)
                    if(compoD.poste.id != nil && compoD.player != nil){
                        self.playersArrayPlay.append(compoD)
                    }
                    if(compoD.poste.id != nil && compoD.poste.id == 15 && compoD.player != nil){
                        self.playersArraySub.append(compoD)
                    }
                    
                }
                self.tableView.reloadData()
                var str = "[\n"
                var dataToSend = [[String: Any]]()
                
                for compoD in self.compodetails {
                    dataToSend.append(compoD.toJsonCreate().dictionaryObject!)
                }

                var jsonData2 = try! JSONSerialization.data(withJSONObject: dataToSend)
                

                let url = URL(string: "http://localhost:8000/api/compositionsdetails/")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                
                request.httpBody = jsonData2
                Alamofire.request(request).responseJSON(completionHandler: { (response) in
                    print(response)
                })

                

            }
        }else{
            Alamoquest.getComposDetailsByCompo(idcompo: self.compo.id) { (composDArray) in
                self.compodetails.removeAll()
                self.playersArrayPlay.removeAll()
                for compoD in composDArray{
                    self.compodetails.append(compoD)
                    if(compoD.poste.id != nil && compoD.player != nil && compoD.poste.id != 15){
                        self.playersArrayPlay.append(compoD)
                    }
                    if(compoD.poste.id != nil && compoD.player != nil && compoD.poste.id == 15){
                        self.playersArraySub.append(compoD)
                    }
                    
                }
                self.tableView.reloadData()
            }
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func saveCompositionDetail(){
        print("Save")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.section == 2){
            return .delete
        }
        else{
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 2){
            return true
        }
        else{
            return false
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            return self.playersArrayPlay.count
        case 2:
            return self.playersArraySub.count
        case 3:
            return self.playersArray.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellCompo = initBtn(tableView: tableView,indexPath: indexPath)
        //cellCompo.dGaucheBtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        
        
        /*let cellTeam = tableView.dequeueReusableCell(withIdentifier: "cellTeam", for: indexPath) as! CompoTableViewCell
        if(cellTeam == nil){
           
        }*/
        let cellTeam =  UITableViewCell(style: .default, reuseIdentifier: "cellTeam")
        
        switch (indexPath.section) {
        case 0:
            return cellCompo
        case 1:
            cellTeam.textLabel?.text = "\(self.playersArrayPlay[indexPath.row].player?.user.firstname ?? "") \((self.playersArrayPlay[indexPath.row].poste.role)! ) \((self.playersArrayPlay[indexPath.row].poste.cote) ?? "")"

            
            return cellTeam
        case 2:
            cellTeam.textLabel?.text = "\((self.playersArraySub[indexPath.row].player?.user.firstname)!).\((self.playersArraySub[indexPath.row].player?.user.name.capitalized.first)!)"
            
            return cellTeam
        case 3:
            cellTeam.textLabel?.text = "\((self.playersArray[indexPath.row].user.firstname)!) \((self.playersArray[indexPath.row].user.name)!)"

            return cellTeam
        default:
            return cellTeam
        }
        


    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Formation : \((self.compo.name)!)"
        case 1:
            return "Titulaires"
        case 2:
            return "Remplaçant"
        case 3:
            return "Equipe"
        default:
            return ""
        }

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textColor = UIColor.black
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        
        switch (section) {
        case 0:
            headerText.text = "Formation : \((self.compo.name)!)"
        case 1:
            headerText.text =  "Titulaires"
        case 2:
            headerText.text =  "Remplaçant"
        case 3:
            headerText.text =  "Equipe"
        default:
            headerText.text =  ""
        }
        
        return headerText
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if(sourceIndexPath == destinationIndexPath){
            return
        }
        switch sourceIndexPath.section {
        case 3:
            tableView.isEditing = false
            var compoR = CompositionDetails()
            compoR.composition = self.compo
            compoR.x = 0
            compoR.y = 0
            compoR.isSub = 0
            compoR.button = -1
            compoR.player = self.playersArray[sourceIndexPath.row]
            for poste in self.posteArray{
                if(poste.id == 15){
                    compoR.poste = poste
                    break
                }
                
            }
            Alamoquest.postCompositionDetails(compo: compoR, completionHandler: { (compod) in
                self.playersArraySub.append(compod)
                for (index, compoPlayer) in self.playersArrayPlay.enumerated() {
                    if(compoPlayer.player!.id == compod.player!.id){
                        self.playersArrayPlay.remove(at: index)
                        break
                    }
                }
                for (index, compoPlayer) in self.compodetails.enumerated() {
                    if(compoPlayer.player?.id == compoR.player!.id){
                        compoPlayer.player = Player()
                        Alamoquest.postCompositionDetails(compo: compoPlayer, completionHandler: { (response) in
                            print(response.toJsonCreate())
                        })
                        break
                    }
                }
                tableView.reloadData()
                tableView.isEditing = true
                return
            })
            return
//            for compoD in self.compodetails{
////                if(compoD.player != nil && compoD.player?.id == self.playersArray[sourceIndexPath.row].id){
////                    for poste in self.posteArray{
////                        if(poste.id == 15){
////                           compoD.poste = poste
////                            break
////                        }
////
////                    }
////                }
//                for poste in self.posteArray{
//                    if(poste.id == 15){
//                        compoD.poste = poste
//                        break
//                    }
//
//                }
//                compoD.button = -1
//                compoD.player = self.playersArray[destinationIndexPath.row]
//                Alamoquest.postCompositionDetails(compo: compoD, completionHandler: { (compod) in
//                    self.playersArraySub.append(compoD)
//                    for (index, compoPlayer) in self.playersArrayPlay.enumerated() {
//                        if(compoPlayer.player!.id == compoD.player!.id){
//                            self.playersArrayPlay.remove(at: index)
//                            break
//                        }
//                    }
//                    tableView.reloadData()
//                    return
//                })
//
//
//            }
            
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if(sourceIndexPath.section == 3 && proposedDestinationIndexPath.section == 2){
            if(self.playersArraySub.count != 0){
                for compoD in self.playersArraySub{
                    if(compoD.player != nil && compoD.player?.id == self.playersArray[sourceIndexPath.row].id){
                        if(compoD.poste.id == 15){
                            return sourceIndexPath
                        }
                    }
                }
            }
            return proposedDestinationIndexPath
        }else{
            return sourceIndexPath
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let sub = UITableViewRowAction(style: .normal, title: "Remplaçant !") { (action, indexPath) in
//            print("Remplaçant !")
//            self.playersArrayPlay[indexPath.row].isSub = 1
//
//            Alamoquest.postCompositionDetails(compo: self.playersArrayPlay[indexPath.row], completionHandler: { (compos) in
//                self.playersArraySub.append(compos)
//                self.playersArrayPlay.remove(at: indexPath.row)
//
//                let contentOffset = self.tableView.contentOffset
//                self.tableView.reloadData()
//                self.tableView.contentOffset = contentOffset
//            })
//
//        }

        let sub = UITableViewRowAction(style: .normal, title: "Sur le terrain ! !") { (action, indexPath) in
            Alamoquest.deleteCompoDetail(idCompositionDetail: self.playersArraySub[indexPath.row].id, completionHandler: { (response) in
                if (response){
                    self.playersArraySub.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            })
        }


        switch (indexPath.section) {
        case 0:
            return nil
        case 1:
            return nil
        case 2:
            return [sub]
        case 3:
            return nil
        default:
            return nil
        }


    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*if(indexPath.row == 1){
         let cellCompo =  tableView.cellForRow(at: indexPath) as! CompoTableViewCell
         //UIImageWriteToSavedPhotosAlbum(cellCompo.capture(), nil, nil, nil)
         }*/
        let index = IndexPath(row: 0, section: 0)
        let cell = self.tableView.cellForRow(at: index) as! CompoTableViewCell
        for subview in cell.viewHolder.subviews{
            if var button = subview as? UIButton {
                button.backgroundColor = UIColor.black
            }
        }
        switch (indexPath.section) {
        case 0:
            return
        case 1:
            let index = IndexPath(row: 0, section: 0)
           /* DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
                // Your code with delay
            }*/
            DispatchQueue.main.async {
                for i in 0...10{
                    let btn = self.tableView.cellForRow(at: index)?.viewWithTag(self.playersArrayPlay[indexPath.row].button)
                    btn?.backgroundColor = UIColor.black
                }

            }
            
           let btn = self.tableView.cellForRow(at: index)?.viewWithTag(self.playersArrayPlay[indexPath.row].button)
            DispatchQueue.main.async {
                btn?.backgroundColor = UIColor.yellow
            }
            return
        case 2:

            /* let index = IndexPath(row: 0, section: 0)
             
             let cell = self.tableView.cellForRow(at: index) as! CompoTableViewCell
             print(cell.viewHolder.subviews.count)
             for subview in cell.viewHolder.subviews{
                if var button = subview as? UIButton {
                    button.backgroundColor = UIColor.gray
                    
                }
            }
             
             for compoD in self.compodetails{
                if(compoD.isSub == 0 && compoD.player != nil){
                    if var button = cell.viewHolder.viewWithTag(compoD.button) as? UIButton {
                        button.backgroundColor = UIColor.black
                    }
                }
             }*/
             
            /*for compoD in self.compodetails{
                print("ID : \(compoD.button)")
                if((compoD.isSub == 0 && compoD.player == nil) || compoD.isSub == 1){
                    for subview in cell.viewHolder.subviews{
                        if let button = subview as? UIButton {
                            if(button.tag == compoD.button){
                                DispatchQueue.main.async {
                                    button.backgroundColor = UIColor.gray
                                }
                                
                            }
                        }
                    }*/
                    /*if let button = cell.viewHolder.viewWithTag(compoD.button) as? UIButton {
                        print("BUTTON : \(button.tag)")
                        button.backgroundColor = UIColor.gray
                    }
                }
             }*/
             
            return
        case 3:
            return
        default:
            return
        }

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch (indexPath.section) {
        case 0:
            return false
        case 1:
            return false
        case 2:
            return true
        case 3:
            return true
        default:
            return false
        }
    }
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.playerArrayPicker.count
        }else{
            return self.posteArray.count
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            return "\((self.playerArrayPicker[row].user.firstname)!) \((self.playerArrayPicker[row].user.name)!)"
        }else{
            return "\((self.posteArray[row].role)!) \((self.posteArray[row].cote) ?? "" )"
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.textField.text =  "\((self.playerArrayPicker[row].user.firstname)!) \((self.playerArrayPicker[row].user.name)!)"
            self.player = self.playersArray[row]
        }else{
            self.textFieldPoste.text = "\((self.posteArray[row].role)!) \((self.posteArray[row].cote) ?? "" )"
            self.poste = self.posteArray[row]
        }

    }
    
    
    func initBtn(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
        let cellCompo =  tableView.dequeueReusableCell(withIdentifier: "compoCell", for: indexPath) as! CompoTableViewCell
        //let cellCompo = CompoTableViewCell(style: .default, reuseIdentifier: "compoCell")
        cellCompo.selectionStyle = UITableViewCellSelectionStyle.none
        
        //cellCompo.viewHolder.alpha = 0
        
        cellCompo.dGaucheBtn.layer.cornerRadius = 10
        cellCompo.dGaucheBtn.clipsToBounds = true
        cellCompo.dGaucheBtn.tag = 0
        cellCompo.dgLabel.tag = 10
        cellCompo.dGaucheBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.dGaucheBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.dGaucheBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        cellCompo.gCentreBtn.layer.cornerRadius = 10
        cellCompo.gCentreBtn.clipsToBounds = true
        cellCompo.gCentreBtn.tag = 1
        cellCompo.dcgLabel.tag = 11
        cellCompo.gCentreBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.gCentreBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.gCentreBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        
        cellCompo.dDroiteBtn.layer.cornerRadius = 10
        cellCompo.dDroiteBtn.clipsToBounds = true
        cellCompo.dDroiteBtn.tag = 3
        cellCompo.ddLabel.tag = 13
        cellCompo.dDroiteBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.dDroiteBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.dDroiteBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        cellCompo.dCentreBtn.layer.cornerRadius = 10
        cellCompo.dCentreBtn.clipsToBounds = true
        cellCompo.dCentreBtn.tag = 2
        cellCompo.dcdLabel.tag = 12
        cellCompo.dCentreBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.dCentreBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.dCentreBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        cellCompo.mGaucheBtn.layer.cornerRadius = 10
        cellCompo.mGaucheBtn.clipsToBounds = true
        cellCompo.mGaucheBtn.tag = 4
        cellCompo.mgLabel.tag = 14
        cellCompo.mGaucheBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.mGaucheBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.mGaucheBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)

        
        cellCompo.mcGaucheBtn.layer.cornerRadius = 10
        cellCompo.mcGaucheBtn.clipsToBounds = true
        cellCompo.mcGaucheBtn.tag = 5
        cellCompo.mcgLabel.tag = 15
        cellCompo.mcGaucheBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.mcGaucheBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.mcGaucheBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        cellCompo.mcDroiteBtn.layer.cornerRadius = 10
        cellCompo.mcDroiteBtn.clipsToBounds = true
        cellCompo.mcDroiteBtn.tag = 6
        cellCompo.mcdLabel.tag = 16
        cellCompo.mcDroiteBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.mcDroiteBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.mcDroiteBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        cellCompo.mDroiteBtn.layer.cornerRadius = 10
        cellCompo.mDroiteBtn.clipsToBounds = true
        cellCompo.mDroiteBtn.tag = 7
        cellCompo.mdLabel.tag = 17
        cellCompo.mDroiteBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.mDroiteBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.mDroiteBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        //cellCompo.aGaucheBtn.layer.cornerRadius = 10
        //cellCompo.aGaucheBtn.clipsToBounds = true
        
        
        cellCompo.acGaucheBtn.layer.cornerRadius = 10
        cellCompo.acGaucheBtn.clipsToBounds = true
        cellCompo.acGaucheBtn.tag = 8
        cellCompo.acgLabel.tag = 18
        cellCompo.acGaucheBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.acGaucheBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        cellCompo.acGaucheBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        

        cellCompo.acDroiteBtn.layer.cornerRadius = 10
        cellCompo.acDroiteBtn.clipsToBounds = true
        cellCompo.acDroiteBtn.tag = 9
        cellCompo.acdLabel.tag = 19
        cellCompo.acDroiteBtn.addTarget(self,
                                       action: #selector(drag(control:event:)),
                                       for: UIControlEvents.touchDragInside)
        cellCompo.acDroiteBtn.addTarget(self,
                                       action: #selector(dragEnd(control:event:)),
                                       for: [UIControlEvents.touchUpInside,])
        cellCompo.acDroiteBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        
        //cellCompo.aDroiteBtn.layer.cornerRadius = 10
        //cellCompo.aDroiteBtn.clipsToBounds = true
        cellCompo.gardienBtn.layer.cornerRadius = 10
        cellCompo.gardienBtn.clipsToBounds = true
        cellCompo.gardienBtn.tag = 20
        cellCompo.gardienLabel.tag = 30
        cellCompo.gardienBtn.addTarget(self,
                                        action: #selector(drag(control:event:)),
                                        for: UIControlEvents.touchDragInside)
        cellCompo.gardienBtn.addTarget(self,
                                        action: #selector(dragEnd(control:event:)),
                                        for: [UIControlEvents.touchUpInside,])
        cellCompo.gardienBtn.addTarget(self, action: #selector(addPlayerToPoste(control:event:)), for: .touchDownRepeat)
        //cellCompo.gardienBtn
        initCompo(cell: cellCompo)
        
        return cellCompo
    }
    
    @objc func drag(control: UIControl, event: UIEvent) {
        //print("\(event.allTouches?.first?.location(in: self.view).x) \(event.allTouches?.first?.location(in: self.view).y)")

        let btn = control as! UIButton
        btn.backgroundColor = UIColor.red
       // btn.frame.origin.x = (event.allTouches?.first?.location(in: self.view).x)! - 24.5

        
        //print("\((event.allTouches?.first?.location(in: btn.superview).y)!) \((event.allTouches?.first?.location(in: btn.superview).x)!)")
        
        btn.frame.origin.y = (event.allTouches?.first?.location(in: btn.superview).y)! - btn.frame.size.height / 2
        btn.frame.origin.x = (event.allTouches?.first?.location(in: btn.superview).x)! - btn.frame.size.width / 2

        let view = btn.superview?.viewWithTag(10 + btn.tag) as! UILabel
        view.frame.origin.x = CGFloat(btn.frame.origin.x) - view.frame.size.width / 4
        view.frame.origin.y = CGFloat(btn.frame.origin.y) + btn.frame.size.height + 5
       // print("\(btn.superview?.frame.size.height) \( btn.superview?.frame.size.width) ")
       // print("\(btn.frame.origin.y) \( btn.frame.origin.x) ")
        //btn.superview?.isUserInteractionEnabled = false
    }
    
    @objc func dragEnd(control: UIControl, event: UIEvent) {
        //print("\(event.allTouches?.first?.location(in: self.view).x) \(event.allTouches?.first?.location(in: self.view).y)")
        
        var btn = control as! UIButton
        btn.backgroundColor = UIColor.black
        //pint("\(btn.frame.origin.x + btn.frame.size.width + 17)")
        //print("\(self.view.frame.size.width)")
        
        if(btn.frame.origin.x < 0){
            btn.frame.origin.x = 0
        }
        if(btn.frame.origin.y < 0){
            btn.frame.origin.y = 5
        }
        if(btn.frame.origin.x + btn.frame.size.width + 20 > self.view.frame.size.width){
            btn.frame.origin.x = self.view.frame.maxX - 65
        }
        
        if(btn.frame.origin.y + btn.frame.size.height > (btn.superview?.frame.size.height)!){
            btn.frame.origin.y = (btn.superview?.frame.size.height)! - 50
        }
        
        /*var compoDetail = CompositionDetails()
        compoDetail.x = Float(btn.frame.origin.x)
        compoDetail.y = Float(btn.frame.origin.y)
        compoDetail.button = btn.tag
        compoDetail.composition = self.compo*/
        let compoDetail = CompositionDetails.getCompo(composdetails: self.compodetails, idCompo: self.compo.id, button: btn.tag)
        compoDetail.x = Float(btn.frame.origin.x)
        compoDetail.y = Float(btn.frame.origin.y)
        compoDetail.button = btn.tag
        compoDetail.composition = self.compo
        compoDetail.isSub = 0
        let view = btn.superview?.viewWithTag(10 + btn.tag) as! UILabel
        view.frame.origin.x = CGFloat(btn.frame.origin.x) - view.frame.size.width / 4
        view.frame.origin.y = CGFloat(btn.frame.origin.y) + btn.frame.size.height + 5
        
        //btn.superview?.isUserInteractionEnabled = true
        print(compoDetail.toJsonCreate())
       Alamoquest.postCompositionDetails(compo: compoDetail) { (compo) in
            print("sucess \(compo)")
        }
        
        
    }
    
    @objc func addPlayerToPoste(control: UIControl, event: UIEvent) {
        for compoD in self.compodetails{
            for (index, player) in self.playerArrayPicker.enumerated(){
                if(compoD.player?.id == player.id && compoD.poste.id != 15){
                    self.playerArrayPicker.remove(at: index)
                }
            }
        }
        
        var btn = control as! UIButton
        
        
        print(btn.tag)
        var compo = CompositionDetails.getCompo(composdetails: self.compodetails, idCompo: self.compo.id, button: btn.tag)
        let alert = UIAlertController(title: "Composition", message: "Creer une composition.", preferredStyle: .alert)
        
        let picker: UIPickerView
        picker = UIPickerView()
        picker.backgroundColor = UIColor.white
        picker.delegate = self
        picker.dataSource = self
        self.pickerView = picker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
        let removeBtn = UIBarButtonItem(title: "Supprimer", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.removePlayer))
        toolBar.setItems([removeBtn], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        alert.addTextField { (textField) in
            textField.placeholder = "Joueur"
            
            
            
            
            textField.inputView = picker
            textField.inputAccessoryView = toolBar
            self.textField = textField
            //self.player = self.playersArray[0]
            //textField.text = "\((self.playersArray[0].firstname)!) \((self.playersArray[0].name)!)"
            textField.tag = 0
            textField.resignFirstResponder()
            if(compo.player!.id != nil){
                for(index, player) in self.playersArray.enumerated(){
                    if(player.id == compo.player!.id){
                        picker.selectRow(index, inComponent: 0, animated: true)
                        textField.tag = player.user.id ?? 0
                        textField.text = "\(player.user.name ?? "") \(player.user.firstname ?? "")"
                        return
                    }
                }
            }
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Poste"
            textField.inputView = picker
            textField.inputAccessoryView = toolBar
            self.textFieldPoste = textField
            
            if(compo.poste.id != nil){
                for (index, poste) in self.posteArray.enumerated(){
                    if (poste.id == compo.poste.id){
                        picker.selectRow(index, inComponent: 1, animated: true)
                        textField.text = "\(poste.role ?? "") \(poste.cote ?? "")"
                        return
                    }
                }
            }
     
            
        }
        
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {action in
            var compod = CompositionDetails.getCompo(composdetails: self.compodetails, idCompo: self.compo.id, button: btn.tag)
            var poste : Poste = self.posteArray[picker.selectedRow(inComponent: 1)]
            var player = Player()
            if(compod.player!.id == nil){
                player  = self.playerArrayPicker[picker.selectedRow(inComponent: 0)]
            }else{
                player = compod.player!
            }
            
            
            
            compod.x = Float(btn.frame.origin.x)
            compod.y = Float(btn.frame.origin.y)
            compod.poste = poste
            compod.player = player
            Alamoquest.postCompositionDetails(compo: compod, completionHandler: { (compo) in
                print(compo)
                let label = btn.superview?.viewWithTag(10 + btn.tag) as! UILabel
                label.frame.origin.x = CGFloat(btn.frame.origin.x) - label.frame.size.width / 4
                label.frame.origin.y = CGFloat(btn.frame.origin.y) + btn.frame.size.height + 5
                label.text = "\(compo.player?.user.firstname ?? "")"
                label.sizeToFit()
                label.isHidden = false
                self.playerArrayPicker.remove(at: picker.selectedRow(inComponent: 0))
                self.playersArrayPlay.append(compo)
                if(self.playersArraySub.count > 0){
                    for (index, playerCompo) in self.playersArraySub.enumerated() {
                        if(playerCompo.player?.id == compod.player?.id){
                            Alamoquest.deleteCompoDetail(idCompositionDetail: playerCompo.id, completionHandler: { (response) in
                                print(response)
                                self.playersArraySub.remove(at: index)
                                self.tableView.reloadData()
                                picker.reloadAllComponents()
                            })
                            break
                        }
                    }
                }
                
                self.tableView.reloadData()
                picker.reloadAllComponents()
            })
            return
            let compoDetail = CompositionDetails()
            compoDetail.x = Float(btn.frame.origin.x)
            compoDetail.y = Float(btn.frame.origin.y)
            compoDetail.button = btn.tag
            compoDetail.composition = self.compo
            compoDetail.poste = self.poste!
            compoDetail.isSub = 0
            if (self.player != nil){
                compoDetail.player = self.player!
            }
            print("Create \(compoDetail.toJsonCreate())")
            Alamoquest.postCompositionDetails(compo: compoDetail) { (compo) in
                self.playersArrayPlay.append(compo)
                self.tableView.reloadData()
                Alamoquest.getComposDetailsByCompo(idcompo: self.compo.id) { (composDArray) in
                    self.compodetails.removeAll()
                    self.playersArraySub.removeAll()
                    self.playersArrayPlay.removeAll()
                    for compoD in composDArray{
                        self.compodetails.append(compoD)
                        if(compoD.poste.id != nil && compoD.isSub != 1){
                            self.playersArrayPlay.append(compoD)
                        }
                        if(compoD.poste.id != nil && compoD.isSub == 1 && compoD.player != nil){
                            self.playersArraySub.append(compoD)
                        }
                    }
                    
                    let label = btn.superview?.viewWithTag(10 + btn.tag) as! UILabel
                    if(compo.player != nil){
                        
                        label.frame.origin.x = CGFloat(btn.frame.origin.x) - label.frame.size.width / 4
                        label.frame.origin.y = CGFloat(btn.frame.origin.y) + btn.frame.size.height + 5
                        label.text = "\((compo.player?.user.firstname)!)"
                        label.sizeToFit()
                        label.isHidden = false
                    }else{
                        label.isHidden = true
                    }
                    
                }
                

            }

            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    @objc func donePicker(sender: UIBarButtonItem){

        
    }
    
    @objc func removePlayer(sender: UIBarButtonItem){
        self.player = nil
        
        if(self.textField.tag == 0){
            return
        }
        var tempPlayer = Player()
        
        for compoD in self.compodetails {
            if(compoD.player != nil){
                print("\(compoD.player?.user.id) - \(self.textField.tag)")
                if(compoD.player?.user.id! == self.textField.tag){
                    tempPlayer = compoD.player!
                    compoD.player = nil
                    Alamoquest.postCompositionDetails(compo: compoD) { (compoD) in
                        self.playerArrayPicker.append(tempPlayer)
                        self.tableView.reloadData()
                        self.pickerView.reloadComponent(0)
                        self.textField.text = ""
                        return
                    }
                }
            }
        }
    }

    
    func initCompo(cell: CompoTableViewCell){
        //self.compodetails.removeAll()
        for composDetails in self.compodetails{

            var btn = cell.viewHolder?.viewWithTag(composDetails.button) as? UIButton
            for view in cell.viewHolder.subviews {
                if(view.tag == composDetails.button && type(of: view) == type(of: UIButton())){
                    view.frame.origin.x = CGFloat(composDetails.x)
                    view.frame.origin.y = CGFloat(composDetails.y)
                }
                if(view.tag == (10 + composDetails.button) && type(of: view) == type(of: UILabel()) && composDetails.isSub != 1){
                    if(composDetails.player != nil){
                        var lbl = view as! UILabel
                        lbl.text = composDetails.player?.user.firstname
                        lbl.sizeToFit()
                        lbl.isHidden = false
                        lbl.frame.origin.x = CGFloat(composDetails.x) - lbl.frame.size.width / 4
                        lbl.frame.origin.y = CGFloat(composDetails.y) + cell.dGaucheBtn.frame.size.height + 5
                    }else{
                        view.isHidden = true
                    }
                    
                    
                }
            }
            
        }

    }
    
    func getCompoDetails(){
        Alamoquest.getComposDetailsByCompo(idcompo: self.compo.id) { (composDArray) in
            self.compodetails.removeAll()
            for compoD in composDArray{
                self.compodetails.append(compoD)
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

extension UITextField {
    public func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool {
        return false
    }
}
