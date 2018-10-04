//
//  ButsTableViewCell.swift
//  Statia
//
//  Created by Nico on 11/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class ButsTableViewCell: UITableViewCell {

    @IBOutlet var nbGoalPlayer: UILabel!
    @IBOutlet var nbGoalTeam: UILabel!
    @IBOutlet var pvGoals: UIProgressView!
    @IBOutlet var nbGoalPerMatch: UILabel!
    @IBOutlet var goalForMin: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPVGoals(player: Int, team: Int) {
        nbGoalPlayer.text = "Joueur (\(player))"
        nbGoalTeam.text = "Equipe (\(team))"
        pvGoals.progress = team == 0 ? 0 : Float(Float(player)/Float(team))
    }
}
