//
//  TableViewCellPlayer.swift
//  Statia
//
//  Created by Nico on 09/05/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class TableViewCellPlayer: UITableViewCell {

    @IBOutlet var showAndHide: UIButton!
    
    @IBAction func showInfos(_ sender: Any) {
        print("TADAM")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
