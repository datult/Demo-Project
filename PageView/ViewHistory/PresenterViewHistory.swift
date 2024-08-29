//
//  PresenterViewHistory.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 10/7/24.
//

import Foundation
import Firebase

protocol ViewHistory_delegate: AnyObject{
    func updateUICollectionView()
    func updateUITableView()
}
class PresenterViewHistory{
    
    var dataQues: DatabaseReference!
    var dataQues1: DatabaseReference!
    var dataQues2: DatabaseReference!
    var dataQues3: DatabaseReference!
    
    var delegate: ViewHistory_delegate?
    var ListTopicName: [String] = []
    var dataMB: [DataMember] = []
    var dataMB_change: [DataMember] = []
    var email_1: String = ""
    func getNameTopic() {
        dataQues1 = Database.database().reference().child("PlayHistory").child("109499177679521049079")
        dataQues1.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    var nameTopic: String = ""
                    nameTopic = i.key
                    self.ListTopicName.append(nameTopic)
                }
            }
            self.delegate?.updateUICollectionView()
        })
    }
    
    func getDataWhenClickCollectionView(_ nameTopic: String){
        dataQues = Database.database().reference().child("PlayHistory").child("109499177679521049079")
        dataQues.child(nameTopic).observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.dataMB.removeAll()
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    let obj = i.value as? [String: AnyObject]
                    let iplayDate = obj?["playDate"]
                    let iscore = obj?["score"]
                    let iUsername = obj?["username"]
                    if self.email_1 == iUsername as! String {
                        let dataMember_1 = DataMember(
                            playDate: iplayDate as? String ?? "",
                            score   : iscore as? Int ?? 0,
                            userName: iUsername as? String ?? "")
                        
                        self.dataMB.append(dataMember_1)
                    }
                }
                
            }
            self.delegate?.updateUITableView()
        })
    }
    func getDataWhenClickTableView(_ index: Int){
                    if index == 0 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        self.dataMB_change = self.dataMB.sorted{ dateFormatter.date(from: $0.playDate)! < dateFormatter.date(from: $1.playDate)!}
                    }else if index == 1 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        self.dataMB_change = self.dataMB.sorted{ dateFormatter.date(from: $0.playDate)! > dateFormatter.date(from: $1.playDate)!}
                    }else if index == 2 {
                        self.dataMB_change = self.dataMB.sorted{$0.score < $1.score}
                    }else if index == 3 {
                        self.dataMB_change = self.dataMB.sorted{$0.score > $1.score}
                    }
            self.dataMB = self.dataMB_change
    }
}
