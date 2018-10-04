//
//  GoalTableViewCell.swift
//  Statia
//
//  Created by Nico on 15/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {

    @IBOutlet var nbCleanSheet: UILabel!
    @IBOutlet var longestSerie: UILabel!
    @IBOutlet var nbGoalForShot: UILabel!
    @IBOutlet var goalForShot: UILabel!
    @IBOutlet var goalForMin: UILabel!
    @IBOutlet var nbSave: UILabel!
    @IBOutlet var nbShot: UILabel!
    @IBOutlet var pvSaveShot: UIProgressView!
    @IBOutlet var nbCapturedBall: UILabel!
    @IBOutlet var nbPushedBall: UILabel!
    @IBOutlet var pbCapturedPushedBall: UIProgressView!
    @IBOutlet var nbIntercept: UILabel!
    @IBOutlet var nbAirGroundIntercept: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPVSaveShot(save: Int, shot: Int) {
        nbSave.text = "\(save) arrêts"
        nbShot.text = "\(shot) tirs subis"
        pvSaveShot.progress = shot == 0 ? 0 : Float(Float(save)/Float(shot))
    }
    
    func setPVCapturedPushedBall(captured: Int, pushed: Int) {
        nbCapturedBall.text = "\(captured) ballons captés"
        nbPushedBall.text = "\(pushed) ballons repoussés"
        pbCapturedPushedBall.progress = captured+pushed == 0 ? 0 : Float(Float(captured)/Float(captured+pushed))
    }
}
