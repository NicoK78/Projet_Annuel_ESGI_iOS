//
//  CompoTableViewCell.swift
//  Statia
//
//  Created by Selom Viadenou on 17/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class CompoTableViewCell: UITableViewCell {
    @IBOutlet var gardienBtn: UIButton!
    
    @IBOutlet  var dGaucheBtn: UIButton!
    @IBOutlet  var gCentreBtn: UIButton!
    @IBOutlet  var dCentreBtn: UIButton!
    @IBOutlet  var dDroiteBtn: UIButton!
    
    @IBOutlet  var mGaucheBtn: UIButton!
    @IBOutlet  var mcGaucheBtn: UIButton!
    @IBOutlet  var mcDroiteBtn: UIButton!
    @IBOutlet  var mDroiteBtn: UIButton!
    
    @IBOutlet  var aGaucheBtn: UIButton!
    @IBOutlet  var acGaucheBtn: UIButton!
    @IBOutlet  var acDroiteBtn: UIButton!
    @IBOutlet  var aDroiteBtn: UIButton!
    @IBOutlet var viewHolder: UIView!
    
    @IBOutlet  var mGauchePos: NSLayoutConstraint!
    @IBOutlet  var defenseView: UIView!
    
    var cellLabel: UILabel!
    
    @IBOutlet var dgLabel: UILabel!
    @IBOutlet var dcgLabel: UILabel!
    @IBOutlet var dcdLabel: UILabel!
    @IBOutlet var ddLabel: UILabel!
    @IBOutlet var mgLabel: UILabel!
    @IBOutlet var mcgLabel: UILabel!
    @IBOutlet var mcdLabel: UILabel!
    @IBOutlet var mdLabel: UILabel!
    @IBOutlet var acgLabel: UILabel!
    @IBOutlet var acdLabel: UILabel!
    @IBOutlet var gardienLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dGaucheBtn = UIButton()
        dgLabel = UILabel()
        dGaucheBtn.tag = 0
        dgLabel.tag = 10
        
        gCentreBtn = UIButton()
        dcgLabel = UILabel()
        gCentreBtn.tag = 1
        dcgLabel.tag = 11
        
        dDroiteBtn = UIButton()
        ddLabel = UILabel()
        dDroiteBtn.tag = 3
        ddLabel.tag = 13
        
        dCentreBtn = UIButton()
        dcdLabel = UILabel()
        dCentreBtn.tag = 2
        dcdLabel.tag = 12
        
        mGaucheBtn = UIButton()
        mgLabel = UILabel()
        mGaucheBtn.tag = 4
        mgLabel.tag = 14
        
        mcGaucheBtn = UIButton()
        mcgLabel = UILabel()
        mcGaucheBtn.tag = 5
        mcgLabel.tag = 15
        
        mcDroiteBtn = UIButton()
        mcdLabel = UILabel()
        mcDroiteBtn.tag = 6
        mcdLabel.tag = 16
        
        mDroiteBtn = UIButton()
        mdLabel = UILabel()
        mDroiteBtn.tag = 7
        mdLabel.tag = 17
        
        acGaucheBtn = UIButton()
        acgLabel = UILabel()
        acGaucheBtn.tag = 8
        acgLabel.tag = 18
        
        acDroiteBtn = UIButton()
        acdLabel = UILabel()
        acDroiteBtn.tag = 9
        acdLabel.tag = 19
        
        viewHolder = UIView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}

extension UIView {
    
    func capture() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
