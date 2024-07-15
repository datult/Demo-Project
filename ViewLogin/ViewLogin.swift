//
//  ViewLogin.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 2/5/24.
//

import UIKit
import Firebase

class ViewLogin: UIViewController {
    
    @IBOutlet weak var button_viewLogin: UIButton!
    @IBOutlet var viewLogin_1: UIView!
    @IBOutlet weak var error_1: UILabel!
    @IBOutlet weak var username_1: UITextField!
    
    var nameUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.error_1.isHidden = true
        button_viewLogin.clipsToBounds = true
        button_viewLogin.layer.cornerRadius = button_viewLogin.frame.height / 2
        button_viewLogin.layer.shadowColor = UIColor.gray.cgColor
        button_viewLogin.layer.shadowOffset = CGSize(width: 2, height: 3)
        button_viewLogin.layer.shadowRadius = 24
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    @IBAction func button_3(_ sender: UIButton) {
        let toPic: ViewTopic =  ViewTopic.newTopic()
        if username_1.text != ""{
            UserInfo.share.nameUser = username_1.text ?? ""
            self.navigationController?.pushViewController(toPic, animated: true)
        }else{
            self.error_1.isHidden = false
            error_1.text = "Moi ban nhap ten! "
        }
    }
    
}
