//
//  HealthTableViewCell.swift
//  Statia
//
//  Created by Nico on 15/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class HealthTableViewCell: UITableViewCell {

    @IBOutlet var disponibility: UILabel!
    @IBOutlet var natureInjury: UILabel!
    @IBOutlet var timeIndisponibility: UILabel!
    @IBOutlet var backDate: UILabel!
    @IBOutlet var recoveryDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
