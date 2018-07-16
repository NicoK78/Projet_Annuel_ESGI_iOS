//
//  TeamTableViewCell.swift
//  Statia
//
//  Created by Selom Viadenou on 03/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet var villeEquipe: UILabel!
    @IBOutlet var nomEquipe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
