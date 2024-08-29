//
//  ViewHistory.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 23/6/24.
//

import UIKit
import Firebase

class ViewHistory: UIViewController,ViewHistory_delegate {

    @IBOutlet weak var tableView_2Layout: NSLayoutConstraint!
    @IBOutlet weak var buttonMucLuc: UIButton!
    @IBOutlet weak var collView_1: UICollectionView!
    @IBOutlet weak var tableView_1: UITableView!
    @IBOutlet weak var tableView_2: UITableView!
    @IBOutlet weak var history_1: UICollectionViewFlowLayout!
    @IBOutlet weak var label_1: UILabel!

    var sapXep: [String] = ["theo ngay tang dan",
                            "theo ngay giam dan",
                            "theo diem tang dan",
                            "theo diem giam dan"]
    var ListTopicName: [String] = []
    var presenter: PresenterViewHistory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PresenterViewHistory()
        presenter?.delegate = self
        presenter?.getNameTopic()
        collView_1.dataSource = self
        collView_1.delegate = self
        tableView_1.dataSource = self
        tableView_1.delegate = self
        tableView_2.dataSource = self
        tableView_2.delegate = self
        label_1.text = presenter?.email_1
        self.tableView_2.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedScreen(touch:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let registerCell = UINib(nibName: "View_muc_lucCell", bundle: nil)
        collView_1.register(registerCell, forCellWithReuseIdentifier: "View_muc_lucCell")
        let registerCell1 = UINib(nibName: "Cell_muc_luc", bundle: nil)
        tableView_1.register(registerCell1, forCellReuseIdentifier: "Cell_muc_luc")
        let registerCell2 = UINib(nibName: "CellSapXep", bundle: nil)
        tableView_2.register(registerCell2, forCellReuseIdentifier: "CellSapXep")
    }
    override func viewWillLayoutSubviews() {
        tableView_2Layout.constant = tableView_2.contentSize.height
    }

    func updateUICollectionView(){
        self.collView_1.reloadData()
        
    }
    
    func updateUITableView(){
        self.tableView_1.reloadData()
    }
    
    @IBAction func handelClick(_ sender: Any) {
        self.tableView_2.isHidden = false
    }
    
    @objc func touchedScreen(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        if touchPoint.x > self.tableView_2.frame.maxX ||
            touchPoint.x < self.tableView_2.frame.minX ||
            touchPoint.y < self.tableView_2.frame.minY ||
            touchPoint.y > self.tableView_2.frame.maxY {
            self.tableView_2.isHidden = true
        }
    }
    
}
extension ViewHistory:  UICollectionViewDelegate,
                       UICollectionViewDataSource,
                       UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.ListTopicName.count ?? 0
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
        getData =  presenter?.ListTopicName[indexPath.row] ?? ""
        presenter?.getDataWhenClickCollectionView(getData)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
    
}
extension ViewHistory: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === tableView_1 {
            return presenter?.dataMB.count ?? 0
        }else if tableView === tableView_2  {
            return sapXep.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === tableView_1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_muc_luc",for: indexPath) as! Cell_muc_luc
            cell.label_1.text =  presenter?.dataMB[indexPath.row].playDate
            cell.label_2.text = "\( presenter?.dataMB[indexPath.row].score ?? 0)"
            return cell
        }else if tableView === tableView_2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSapXep",for: indexPath) as! CellSapXep
            cell.label_1.text = sapXep[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView === tableView_2{
            presenter?.getDataWhenClickTableView(indexPath.row)
            tableView_2.deselectRow(at: indexPath, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1645){
                self.tableView_2.isHidden = true
            }
            self.tableView_1.reloadData()
        }
        
    }
}

