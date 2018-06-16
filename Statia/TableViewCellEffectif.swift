//
//  TableViewCellEffectif.swift
//  Statia
//
//  Created by Selom Viadenou on 15/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TableViewCellEffectif: UITableViewCell {

    @IBOutlet var labelPoste: UILabel!
    @IBOutlet var labelPrenom: UILabel!
    @IBOutlet var labelNom: UILabel!
    @IBOutlet var photoProfil: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
