//
//  TeamResultatTableViewCell.swift
//  Statia
//
//  Created by Selom Viadenou on 13/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TeamResultatTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTeam: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
