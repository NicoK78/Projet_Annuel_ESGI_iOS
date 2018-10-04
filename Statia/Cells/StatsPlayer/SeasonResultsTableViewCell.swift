//
//  SeasonResultsTableViewCell.swift
//  Statia
//
//  Created by Nico on 11/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import QuartzCore

class SeasonResultsTableViewCell: UITableViewCell {

    @IBOutlet var svResults: UIStackView!
    @IBOutlet var nbWins: UILabel!
    @IBOutlet var nbDraw: UILabel!
    @IBOutlet var nbLose: UILabel!
    @IBOutlet var nbButs: UILabel!
    @IBOutlet var nbParticipations: UILabel!
    @IBOutlet var nbLastPass: UILabel!
    @IBOutlet var pvParticipations: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setResults(win: Int, draw: Int, lose: Int) {
        let tmp: Float =  (win+draw+lose) == 0 ? 0 : 100.0/Float(win+draw+lose)
        nbWins.text = "\(win) V (\(Int((Float(win)*tmp).rounded()))%)"
        nbWins.layer.backgroundColor  = UIColor.green.cgColor
        nbWins.layer.cornerRadius = 10
        nbDraw.text = "\(draw) N (\(Int((Float(draw)*tmp).rounded()))%)"
        nbDraw.layer.backgroundColor  = UIColor.yellow.cgColor
        nbDraw.layer.cornerRadius = 10
        nbLose.text = "\(lose) D (\(Int((Float(lose)*tmp).rounded()))%)"
        nbLose.layer.backgroundColor  = UIColor.red.cgColor
        nbLose.layer.cornerRadius = 10
    }
    
    func setPVParticipation(goal: Int, pass: Int) {
        nbButs.text = "\(goal) buts"
        nbParticipations.text = "\(goal+pass)"
        nbLastPass.text = "\(pass) p. décisives"
        pvParticipations.progress = (goal+pass) == 0 ? 0 : Float(Float(goal)/(Float(goal)+Float(pass)))
    }
}
