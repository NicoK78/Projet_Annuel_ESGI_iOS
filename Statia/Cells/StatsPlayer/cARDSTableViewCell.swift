//
//  CardsTableViewCell.swift
//  Statia
//
//  Created by Nico on 14/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    @IBOutlet var nbYellowCard: UILabel!
    @IBOutlet var nbTeamYellowCard: UILabel!
    @IBOutlet var nbAverageYellowCard: UILabel!
    @IBOutlet var nbPerMinYellowCard: UILabel!
    @IBOutlet var nbRedCard: UILabel!
    @IBOutlet var nbTeamRedCard: UILabel!
    @IBOutlet var nbAverageRedCard: UILabel!
    @IBOutlet var nbPerMinRedCard: UILabel!
    @IBOutlet var nbExpulsion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
