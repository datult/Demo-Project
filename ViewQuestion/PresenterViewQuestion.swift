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
    var allQues: [QuestionResponse] = []

    func checkAnswer() {
        if self.allQues[self.cauSo].dapAn[model.thuTuDapAn] == self.dapAnDung {
            model.score += 1
        }
    }
    func addMember(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        
        dataScore  = Database.database().reference().child("PlayHistory").child("109499177679521049079").child(model.nameTopic).child("something_\(Int.random(in: 0..<100))")
        
        let dataOfMember: [String: Any] = ["playDate": result,
                                           "score": model.score,
                                           "username": model.nameUser]
        dataScore.setValue(dataOfMember)
        
    }
}
