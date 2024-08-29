//
//  CellBackGround.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 22/7/24.
//

import UIKit
protocol UICollectionViewDelegate2 {
    func getColor(x: UIColor)
}
class CellBackGround: UITableViewCell {

    @IBOutlet weak var switch_1: UISwitch!
    @IBOutlet weak var label_1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    
    }
    
    @IBAction func hanhdelClick(_ sender: Any) {
    }
}
