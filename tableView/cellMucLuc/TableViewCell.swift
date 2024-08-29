//
//  TableViewCell.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 6/5/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var VIEW_1: UIView!
    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var img_2: UIImageView!
    @IBOutlet weak var label_3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        VIEW_1.layer.cornerRadius = VIEW_1.frame.height/9
       // VIEW_1.layer.shadowOffset = CGSize(width: 5, height: 5)
        VIEW_1.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        VIEW_1.layer.shadowOpacity = 1.0
        VIEW_1.layer.shadowRadius = 2.0
        VIEW_1.layer.masksToBounds = false
        img_1.clipsToBounds = true
        img_1.layer.cornerRadius = img_1.frame.height / 5
        img_1.layer.shadowColor = UIColor.gray.cgColor
        img_1.layer.shadowOffset = CGSize(width: 2, height: 3)
        img_2.layer.masksToBounds = true
        img_2.layer.cornerRadius = img_2.frame.height/2
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
