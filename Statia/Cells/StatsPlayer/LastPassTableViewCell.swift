//
//  LastPassTableViewCell.swift
//  Statia
//
//  Created by Nico on 12/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class LastPassTableViewCell: UITableViewCell {

    @IBOutlet var nbPassPlayer: UILabel!
    @IBOutlet var nbPassTeam: UILabel!
    @IBOutlet var pvLastPass: UIProgressView!
    @IBOutlet var nbPassPerMatch: UILabel!
    @IBOutlet var passForMin: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPVLastPass(player: Int, team: Int) {
        nbPassPlayer.text = "Joueur (\(player))"
        nbPassTeam.text = "Equipe (\(team))"    
        pvLastPass.progress = team == 0 ? 0 : Float(Float(player)/Float(team))
    }
}
