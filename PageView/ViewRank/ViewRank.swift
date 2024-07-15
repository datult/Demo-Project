//
//  ViewRank.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 23/6/24.
//

import UIKit
import Firebase

class ViewRank: UIViewController, ViewRank_Delegate{
   
    
    @IBOutlet weak var coll_1: UICollectionView!
    @IBOutlet weak var tableView_1: UITableView!
    
    var presenter: PresenterViewRank?
//    var dataQues: DatabaseReference!
//    var dataQues1: DatabaseReference!
//    var ListTopicName: [String] = []
//    var dataMB: [DataMember] = []
//    var dataMB_Rank: [DataMember] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        coll_1.dataSource = self
        coll_1.delegate = self
        tableView_1.dataSource = self
        tableView_1.delegate = self
        presenter = PresenterViewRank()
        let flowLayout = UICollectionViewFlowLayout()
         flowLayout.scrollDirection = .vertical
        coll_1.collectionViewLayout = flowLayout
        
        presenter?.getNameTopic()
        presenter?.delegate = self
        
        
        let registerCell = UINib(nibName: "View_muc_lucCell", bundle: nil)
        coll_1.register(registerCell, forCellWithReuseIdentifier: "View_muc_lucCell")
        let registerCell1 = UINib(nibName: "Cell_muc_luc", bundle: nil)
        tableView_1.register(registerCell1, forCellReuseIdentifier: "Cell_muc_luc")
    }
    
//    func getSubject() {
//        dataQues1 = Database.database().reference().child("PlayHistory").child("109499177679521049079")
//        dataQues1.observe(DataEventType.value, with: {(snapshot) in
//            if snapshot.childrenCount > 0{
//                for i in snapshot.children.allObjects as![DataSnapshot]{
//                    var nameTopic: String = ""
//                    nameTopic = i.key
//                    self.ListTopicName.append(nameTopic)
//                    
//                }
//            }
//            self.coll_1.reloadData()
//        })
// 
//    }
    func updateUICollectionView(){
        DispatchQueue.main.async {
            self.coll_1.reloadData()
        }
        
    }
    
    func updateUITableView(){
        self.tableView_1.reloadData()
    }
}
extension ViewRank: UICollectionViewDelegate,
                    UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  presenter?.ListTopicName.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "View_muc_lucCell",for: indexPath) as! View_muc_lucCell
        cell.label_1.text = presenter?.ListTopicName[indexPath.row]
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        var getData: String = ""
        getData = presenter?.ListTopicName[indexPath.row] ?? ""
        presenter?.getDataWhenClickCollectionView(getData)
//        dataQues = Database.database().reference().child("PlayHistory").child("109499177679521049079")
//        dataQues.child(getData).observe(DataEventType.value, with: {(snapshot) in
//            
//            if snapshot.childrenCount > 0{
//                self.dataMB.removeAll()
//                for i in snapshot.children.allObjects as![DataSnapshot]{
//                    let obj = i.value as? [String: AnyObject]
//                    let iplayDate = obj?["playDate"]
//                    let iscore = obj?["score"]
//                    let iUsername = obj?["username"]
//                     
//                    let dataMember_1 = DataMember(
//                        playDate: iplayDate as? String ?? "",
//                        score   : iscore as? Int ?? 0,
//                        userName: iUsername as? String ?? "")
//                    
//                    self.dataMB.append(dataMember_1)
//                    
//                }
//            }
//                    
//            self.dataMB_Rank =  self.dataMB.sorted{$0.score > $1.score}
//            self.tableView_1.reloadData()
//        })
       
    }
    
}
extension ViewRank: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataMB_Rank.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_muc_luc",for: indexPath) as! Cell_muc_luc
        cell.label_1.text = presenter?.dataMB_Rank[indexPath.row].userName
        cell.label_2.text = "\(presenter?.dataMB_Rank[indexPath.row].score ?? 0)"
        return cell
    }
    
    
}
