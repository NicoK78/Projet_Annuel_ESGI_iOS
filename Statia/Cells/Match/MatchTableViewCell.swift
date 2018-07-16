//
//  MatchTableViewCell.swift
//  Statia
//
//  Created by Selom Viadenou on 12/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    @IBOutlet var homeClublabel: UILabel!
    @IBOutlet var homeTeamlabel: UILabel!
    @IBOutlet var awayClublabel: UILabel!
    @IBOutlet var awayTeamLabel: UILabel!
    @IBOutlet var competitionLabel: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var homeGoalLabel: UILabel!
    @IBOutlet var awayGoalLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
