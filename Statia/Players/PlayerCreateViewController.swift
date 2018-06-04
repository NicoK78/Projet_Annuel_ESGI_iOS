//
//  PlayerCreateViewController.swift
//  Statia
//
//  Created by Selom Viadenou on 02/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class PlayerCreateViewController: UIViewController {

    @IBOutlet var birthdayLabel: UITextField!
    
    @IBOutlet var pickerBirthday: UIDatePicker!
    @IBOutlet var labelAge: UILabel!
    
    @IBOutlet var imgLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().userInterfaceIdiom == .phone {
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
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCreatePLayer))
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_blue.jpg")!)
            pickerBirthday.isHidden = true
        pickerBirthday.addTarget(self, action: #selector(pickerBirthdayChange(sender:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func pickerBirthdayChange(sender: UIDatePicker){
        
        let formater = DateFormatter()
        
        formater.dateStyle = DateFormatter.Style.long
        
        formater.timeStyle = DateFormatter.Style.none
        
        formater.locale = Locale(identifier: "FR-fr")
        
        birthdayLabel.text = formater.string(from: sender.date)
        
        labelAge.text = "\(Date.getAgefromDate(birthDate: sender.date)) ans"
    }
    
    @objc func doneCreatePLayer(){
        
    }

    @IBAction func hideDateBirth(_ sender: Any) {
        pickerBirthday.isHidden = true
    }
    
    @IBAction func showPickerBirthday(_ sender:Any){
        pickerBirthday.isHidden = false
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
