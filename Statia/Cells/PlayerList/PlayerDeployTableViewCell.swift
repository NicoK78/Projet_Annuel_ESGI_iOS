//
//  PlayerDeployTableViewCell.swift
//  Statia
//
//  Created by Nico on 17/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

protocol PlayerDeployDelegate: AnyObject {
    func deploy(cell: PlayerDeployTableViewCell)
}

class PlayerDeployTableViewCell: UITableViewCell {

    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelPost: UILabel!
    @IBOutlet var photoProfile: UIImageView!
    @IBOutlet var btnDeploy: UIButton!
    
    weak var delegate: PlayerDeployDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func undeploy(_ sender: Any) {
        delegate?.deploy(cell: self)
    }
}
