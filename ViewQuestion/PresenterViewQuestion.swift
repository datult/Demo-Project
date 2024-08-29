//
//  PresenterViewQuestion.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 9/7/24.
//

import Foundation
import Firebase

protocol Delegate: AnyObject {
    
}
class PresenterViewQuestion {
    var Delegate_1: Delegate?
    var model = ModelViewQuestion()
    var cauSo = 0
    var viTri: String = ""
    var dapAnDung: String = ""
    var dataScore: DatabaseReference!
    var dataScore1: DatabaseReference!
    var allQues: [QuestionResponse] = []
    
    func checkAnswer() {
        if self.allQues[self.cauSo].dapAn[model.thuTuDapAn] == self.dapAnDung {
            model.score += 1
        }
    }
    func addMember() {
        var totalNumberAttempt = 0
        var LastTimeToDoTheTest = ""
        if !model.nameTopic.isEmpty {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let result = formatter.string(from: date)
            LastTimeToDoTheTest = result
            dataScore  = Database.database().reference()
                .child("PlayHistory")
                .child("109499177679521049079")
                .child(model.nameTopic)
                .child("something_\(Int.random(in: 0..<100))")
            
            let dataOfMember: [String: Any] = ["playDate": result,
                                               "score": model.score,
                                               "username": model.nameUser]
            
            dataScore.setValue(dataOfMember)
            
        }
        if let userID = UserDefaults.standard.string(forKey: "currentID") {
             dataScore1 = Database.database().reference().child("Users")
            dataScore1.child(userID).observe(DataEventType.value,with: {(snapshot) in
                if snapshot.childrenCount > 0{
                    for i in snapshot.children.allObjects as![DataSnapshot]{
                        let obj = i.value as? [String: AnyObject]
                        totalNumberAttempt = obj?["totalNumberAttempt"] as? Int ?? 0
                    }
                }
            })
            totalNumberAttempt += 1
            dataScore1.child(userID).updateChildValues(["totalNumberOfAttempt": totalNumberAttempt])
            dataScore1.child(userID).updateChildValues(["LastTimeToDoTheTest": LastTimeToDoTheTest])
            print("123123123123",totalNumberAttempt)
        } else {
            print("User ID not found")
        }
    }
}
    
