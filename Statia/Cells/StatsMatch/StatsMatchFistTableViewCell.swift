//
//  StatsMatchFistTableViewCell.swift
//  Statia
//
//  Created by Selom Viadenou on 23/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class StatsMatchFistTableViewCell: UITableViewCell {
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var awayLabel: UILabel!
    @IBOutlet var homeScoreLabel: UILabel!
    @IBOutlet var awayScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
