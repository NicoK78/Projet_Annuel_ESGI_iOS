//
//  ModifyInfoPlayerTableViewCell.swift
//  Statia
//
//  Created by Nico on 17/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

protocol ModifyInfosDelegate: AnyObject {
    func modifyInfos(cell: ModifyInfoPlayerTableViewCell)
}
class ModifyInfoPlayerTableViewCell: UITableViewCell {

    @IBOutlet var btnModify: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    weak var delegate: ModifyInfosDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func modifyInfos(_ sender: Any) {
        delegate?.modifyInfos(cell: self)
    }
}
