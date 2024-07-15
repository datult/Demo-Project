//
//  ViewCongrat.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 16/6/24.
//

import UIKit

class ViewCongrat: UIViewController {
    @IBOutlet weak var viewShadown: UIView!
    
    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var viewImg: UIView!
    
    var score: Int = 0
    var totalQues: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewImg.translatesAutoresizingMaskIntoConstraints = false
        
        button_1.clipsToBounds = true
        button_1.layer.cornerRadius = button_1.frame.height / 2
        button_1.layer.shadowColor = UIColor.gray.cgColor
        button_1.layer.shadowOffset = CGSize(width: 2, height: 3)
        button_1.layer.shadowRadius = 24
        button_2.clipsToBounds = true
        button_2.layer.cornerRadius = button_2.frame.height / 2
        button_2.layer.shadowColor = UIColor.gray.cgColor
        button_2.layer.shadowOffset = CGSize(width: 2, height: 3)
        button_2.layer.shadowRadius = 24
        button_2.layer.borderWidth = 1
        button_2.layer.borderColor = UIColor.white.cgColor
        label_1.text = "\(score)/\(totalQues)"
    }
    @IBAction func handelBack(_ sender: Any) {
        for i in self.navigationController?.viewControllers ?? [] {
            if let i = i as? ViewTopic{
                self.navigationController?.popToViewController(i, animated: true)
                return 
            }
        }
    }
    
}


