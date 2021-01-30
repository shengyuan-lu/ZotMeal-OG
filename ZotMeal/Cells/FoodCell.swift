//
//  FoodCell.swift
//  ZotMeal
//
//  Created by Shengyuan Lu on 1/29/21.
//

import UIKit

class FoodCell: UITableViewCell {

    // IBOUtlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desTextView: UITextView!
    @IBOutlet weak var calLabel: UILabel!
    
    var food:Food! {
        didSet {
            self.nameLabel.text = food.name
            self.calLabel.text = String(food.calories) + " Cal"
            self.desTextView.text = food.description
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        desTextView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
