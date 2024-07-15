//
//  PresenterViewRank.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 10/7/24.
//

import Foundation
import Firebase

protocol ViewRank_Delegate: AnyObject{
    func updateUICollectionView()
    func updateUITableView()
}
class PresenterViewRank{
    var delegate: ViewRank_Delegate?
    var dataQues: DatabaseReference!
    var dataQues1: DatabaseReference!
    var ListTopicName: [String] = []
    var dataMB: [DataMember] = []
    var dataMB_Rank: [DataMember] = []
    
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
                     
                    let dataMember_1 = DataMember(
                        playDate: iplayDate as? String ?? "",
                        score   : iscore as? Int ?? 0,
                        userName: iUsername as? String ?? "")
                    
                    self.dataMB.append(dataMember_1)
                    
                }
            }
                    
            self.dataMB_Rank =  self.dataMB.sorted{$0.score > $1.score}
            self.delegate?.updateUITableView()
        })
    }
    
    
}
