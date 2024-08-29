//
//  PresenterViewTopicInPV.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 9/7/24.
//

import Foundation
import UIKit
import Firebase

protocol ViewTopicInPV_Delegate: AnyObject{
    func updateUITableView(ListTopicName: [String],
                           terms: [String],
                           img: [String])
    func putViewQuestion(_ nameTopic: String, allQues: [QuestionResponse])
}
class PresenterViewTopicInPV {
    var viewTopicInPV_Delegate: ViewTopicInPV_Delegate?
    var ListTopicName: [String] = []
    var img: [String] = []
    var terms: [String] = []
    var allQuestion: [QuestionResponse] = []
    var dataQues: DatabaseReference!
    var dataQues1: DatabaseReference!
    var dataQues2: DatabaseReference!
    var dataQues3: DatabaseReference!
    
    func getData()  {
        dataQues1 = Database.database().reference().child("1urSOD9SR3lSD7WE1SF0CqKRa7c1INR9I-iMqQgwsKvM")
        dataQues1.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.ListTopicName.removeAll()
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    var nameTopic: String = ""
                    nameTopic = i.key // gan nameTopic  =  
                    self.ListTopicName.append(nameTopic)
                }
            }
        })
        dataQues3 = Database.database().reference().child("terms")
        dataQues3.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.terms.removeAll()
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    var nameTerm: String = ""
                    nameTerm = i.key
                    self.terms.append(nameTerm)
                }
            }
        })
        dataQues2 = Database.database().reference().child("Img")
        dataQues2.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.img.removeAll()
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    var nameImg: String = ""
                    nameImg = i.key
                    self.img.append(nameImg)
                }
            }
            self.viewTopicInPV_Delegate?.updateUITableView(ListTopicName: self.ListTopicName,terms: self.terms,img: self.img)
            
        })
        
    }
    
    func getDataWhenClick(_ nameTopic: String) {
        
        dataQues = Database.database().reference().child("1urSOD9SR3lSD7WE1SF0CqKRa7c1INR9I-iMqQgwsKvM")
        dataQues.child(nameTopic).observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.allQuestion.removeAll()
                
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    let obj = i.value as? [String: AnyObject]
                    let icauHoi = obj?["Question"]
                    var idapAn: [String] = []
                    idapAn.append(obj?["Choice1"] as? String ?? "")
                    idapAn.append(obj?["Choice2"] as? String ?? "")
                    idapAn.append(obj?["Choice3"] as? String ?? "")
                    idapAn.append(obj?["Choice4"] as? String ?? "")
                    let idADung = obj?["Answer"]
                    
                    let cauHoiHoanChinh = QuestionResponse( cauHoi: icauHoi as? String ?? "",
                                                            dapAn:  idapAn,
                                                            dADung: idADung as? String ?? "")
                    
                    self.allQuestion.append(cauHoiHoanChinh)
                    
                }
            }
            
            self.viewTopicInPV_Delegate?.putViewQuestion(nameTopic,allQues: self.allQuestion)
            
        })
    }
}
