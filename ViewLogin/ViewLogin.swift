//
//  ViewLogin.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 2/5/24.
//

import UIKit
import Firebase

class ViewLogin: UIViewController,UITabBarDelegate {
    
    
    @IBOutlet weak var tabBarHis: UITabBarItem!
    @IBOutlet weak var button_viewLogin: UIButton!
    @IBOutlet var viewLogin_1: UIView!
    @IBOutlet weak var error_1: UILabel!
    @IBOutlet weak var username_1: UITextField!
    
    
    var dataScore: DatabaseReference!
    var dataScore1: DatabaseReference!
    var nameUser: String = ""
    var m = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.error_1.isHidden = true
        
        button_viewLogin.clipsToBounds = true
        button_viewLogin.layer.cornerRadius = button_viewLogin.frame.height / 2
        button_viewLogin.layer.shadowColor = UIColor.gray.cgColor
        button_viewLogin.layer.shadowOffset = CGSize(width: 2, height: 3)
        button_viewLogin.layer.shadowRadius = 24
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func button_3(_ sender: UIButton) {
        if self.username_1.text != ""{
            getData()
        }else{
            self.error_1.isHidden = false
            error_1.text = "Moi ban nhap ten! "
        }
    }
    //check xem da co user nay trong firebase chua
    func getData(){
        let tabBar: ViewTabbar = .init()
        UserInfo.share.nameUser = self.username_1.text ?? ""
        dataScore1  = Database.database().reference().child("Users")
        dataScore1.observe(DataEventType.value,with: {(snapshot) in
            if snapshot.childrenCount > 0{
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    let obj = i.value as? [String: AnyObject]
                    let iName = obj?["nameUser"] as? String
                    
                    if self.username_1.text == iName{
                        self.m += 1
                        UserInfo.share.nameUser = iName ?? ""
                        let iPhoto = obj?["imgProfile"] as? String
                        UserInfo.share.imgProfile = iPhoto ?? ""
                        let iTotal = obj?["totalNumberOfAttempt"] as? Int
                        UserInfo.share.totalNumberAttempt = iTotal ?? 0
                        let iLastTime = obj?["LastTimeToDoTheTest"] as? String
                        UserInfo.share.lastTimetoDoTest = iLastTime ?? ""
                        UserDefaults.standard.setValue(i.key, forKey: "currentID")
                    }
                }
            }
            if self.m == 0 {
                //tao id ngay nhien va luu vao UserDefaults va them ten vao firebase voi id do
                self.dataScore  = Database.database().reference().child("Users")
                let userID = self.dataScore.childByAutoId().key
                UserDefaults.standard.setValue(userID, forKey: "currentID")
                self.dataScore.child(userID!).setValue(["nameUser" : UserInfo.share.nameUser,
                                                    "imgProfile": UserInfo.share.imgProfile,
                                                    "totalNumberOfAttempt": UserInfo.share.totalNumberAttempt,
                                                    "LastTimeToDoTheTest": UserInfo.share.lastTimetoDoTest])
            }
        })
        self.navigationController?.pushViewController(tabBar, animated: true)
    }

}
extension ViewLogin{
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewLogin.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
