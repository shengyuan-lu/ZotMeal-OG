//
//  CreditCell.swift
//  ZotMeal
//
//  Created by Jingqi Yao on 2021/1/31.
//

import UIKit

class CreditCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bioTextView.isScrollEnabled = false
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
