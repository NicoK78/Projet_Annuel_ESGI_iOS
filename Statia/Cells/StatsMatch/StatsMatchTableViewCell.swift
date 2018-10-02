//
//  StatsMatchTableViewCell.swift
//  Statia
//
//  Created by Selom Viadenou on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import GTProgressBar

class StatsMatchTableViewCell: UITableViewCell {
    @IBOutlet var labelHome: UILabel!
    @IBOutlet var labelStat: UILabel!
    @IBOutlet var labelAway: UILabel!
    @IBOutlet var progressBar: GTProgressBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
