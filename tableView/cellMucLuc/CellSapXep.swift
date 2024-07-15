//
//  CellSapXep.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 3/7/24.
//

import UIKit

class CellSapXep: UITableViewCell {

    @IBOutlet weak var label_1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        var teamBackGround = self.backgroundColor
//        self.backgroundColor = .gray
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//            self.backgroundColor = teamBackGround
//        }
        // Configure the view for the selected state
    }
    
}
