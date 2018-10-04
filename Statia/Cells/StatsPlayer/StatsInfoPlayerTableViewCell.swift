//
//  StatsInfoPlayerTableViewCell.swift
//  Statia
//
//  Created by Nico on 09/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class StatsInfoPlayerTableViewCell: UITableViewCell {

    @IBOutlet var picture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var post: UILabel!
    @IBOutlet var foot: UILabel!
    @IBOutlet var phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
