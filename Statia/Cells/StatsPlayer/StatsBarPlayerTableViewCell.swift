//
//  StatsBarPlayerTableViewCell.swift
//  Statia
//
//  Created by Nico on 06/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class StatsBarPlayerTableViewCell: UITableViewCell {
    
    @IBOutlet var labelleft: UILabel!
    @IBOutlet var labelcenter: UILabel!
    @IBOutlet var labelright: UILabel!
    @IBOutlet var progressview: UIProgressView!
    
//    var textleft: String?
//    var textcenter: String?
//    var textright: String?
//    
//    var values: Array<Float>?
//    var colors: Array<String>?
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if let textleft = textleft {
//            print(textleft)
//            labelleft.text = textleft
//        }
//        if let textcenter = textcenter {
//            labelcenter.text = textcenter
//        }
//        if let textright = textright {
//            labelright.text = textright
//        }
//        
//        
//        //if let values = values {
//            // SET VALUES IN PERCENT FOR THE BAR
//        //}
//        //if let colors = colors {
//            // SET COLORS TO BAR
//        //}
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
