//
//  CreditCell.swift
//  ZotMeal
//
//  Created by Jingqi Yao on 2021/1/31.
//

import UIKit

class CreditCell: UITableViewCell {

    @IBOutlet weak var pictureVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureVIew.layer.masksToBounds = true
        pictureVIew.layer.cornerRadius = pictureVIew.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
