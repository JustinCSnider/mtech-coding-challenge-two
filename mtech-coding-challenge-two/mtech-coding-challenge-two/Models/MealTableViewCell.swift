//
//  MealTableViewCell.swift
//  mtech-coding-challenge-two
//
//  Created by Justin Snider on 5/16/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //========================================
    //MARK: - IBOulets
    //========================================
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
