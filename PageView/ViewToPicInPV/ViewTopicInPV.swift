//
//  ViewTopicInPV.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 23/6/24.
//

import UIKit
import Firebase

class ViewTopicInPV: UIViewController, ViewTopicInPV_Delegate{

    @IBOutlet weak var tableView_1: UITableView!
    
    var presenter: PresenterViewTopicInPV?
    var ListTopicName: [String] = []
    var img: [String] = []
    var terms: [String] = []
    let myRefresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PresenterViewTopicInPV()
        presenter?.viewTopicInPV_Delegate = self
        presenter?.getData()
        myRefresh.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        tableView_1.dataSource = self
        tableView_1.delegate = self
        tableView_1.refreshControl = myRefresh
        let registerCell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView_1.register(registerCell, forCellReuseIdentifier: "TableViewCell")
       
    }
    
    @objc private func refreshData(sender: UIRefreshControl){
        self.ListTopicName.removeAll()
        self.img.removeAll()
        self.terms.removeAll()
        presenter?.getData()
        sender.endRefreshing()
    }

    func updateUITableView(ListTopicName: [String],
                           terms: [String],
                           img: [String]) {
        self.img = img
        self.terms = terms
        self.ListTopicName = ListTopicName
        self.tableView_1.reloadData()
    }
   
    func putViewQuestion(_ nameTopic: String,
                         allQues: [QuestionResponse]) {
        let questions = ViewQuestion()
        questions.presenter.allQues = allQues
        questions.presenter.model.nameTopic = nameTopic
        questions.presenter.model.nameUser = UserInfo.share.nameUser
        self.navigationController?.pushViewController(questions, animated: true)
    }
}
extension ViewTopicInPV: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListTopicName.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === tableView_1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath) as! TableViewCell
            cell.label_1.text = self.ListTopicName[indexPath.row]
            cell.img_1.image = UIImage(named: self.img[indexPath.row])
            cell.label_2.text = self.terms[indexPath.row]
            cell.label_3.text = "aly+sarfraz PLUS"
            cell.img_2.image = UIImage(named: "Image 1")
            
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var getData: String = ""
        getData = ListTopicName[indexPath.row]
        presenter?.getDataWhenClick(getData)
        
        }

}
