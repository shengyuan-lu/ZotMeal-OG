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
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var foodCellBGView: UIView!
    
    var food:Food! {
        didSet {
            self.nameLabel.text = food.name
            self.calLabel.text = String(food.calories) + " Calories"
            self.desTextView.text = food.description
            
            if food.description == "N/A" {
                self.desTextView.text = "No description provided."
            }
            
            while true {
                if food.isVegan {
                    self.badgeImageView.image = UIImage(named: "Vegan")
                    break
                }
                
                if food.isEatWell {
                    self.badgeImageView.image = UIImage(named: "EatWell")
                    break
                }
                
                if food.isVegetarian {
                    self.badgeImageView.image = UIImage(named: "Vegetarian")
                    break
                }
                
                if food.isWholeGrains {
                    self.badgeImageView.image = UIImage(named: "WholeGrains")
                    break
                }
                
                if food.isPlantForward {
                    self.badgeImageView.image = UIImage(named: "PlantForward")
                    break
                }
                
                break
            }
            
            if food.calories <= 250 {
                calLabel.textColor = .systemGreen
            } else if food.calories <= 400 {
                calLabel.textColor = .orange
            } else if food.calories > 400 {
                calLabel.textColor = .red
            }

        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.badgeImageView.backgroundColor = .clear
        self.desTextView.isScrollEnabled = false
        self.foodCellBGView.layer.cornerRadius = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
