//
//  StatsInfoPlayerTableViewCell.swift
//  Statia
//
//  Created by Nico on 09/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

protocol StatsInfosDelegate: AnyObject {
    func modifyInfos(cell: StatsInfoPlayerTableViewCell)
}
class StatsInfoPlayerTableViewCell: UITableViewCell {

    @IBOutlet var btnModify: UIButton!
    
    weak var delegate: StatsInfosDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func modifyInfos(_ sender: Any) {
        print("CLICK")
        delegate?.modifyInfos(cell: self)
    }
}
