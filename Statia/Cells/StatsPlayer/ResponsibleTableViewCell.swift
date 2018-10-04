//
//  ResponsibleTableViewCell.swift
//  Statia
//
//  Created by Nico on 10/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class ResponsibleTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var email: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
