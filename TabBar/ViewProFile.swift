//
//  ViewProFile.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 21/7/24.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewProFile: UIViewController {
    
    @IBOutlet weak var phoTo: UIImageView!
    @IBOutlet weak var textProfile: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var tableView_func: UITableView!
    @IBOutlet weak var name_1: UILabel!
    @IBOutlet weak var img_1: UIView!
    
    var dataQues: DatabaseReference!
    var dataQues1: DatabaseReference!
    let storage = Storage.storage().reference()
    var inFo: [String] = ["Edit information",
                          "Total number of attempts",
                          "Last time to do the test",
                          "Change BackgroundColor"]
    var checkColor = false
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.name_1.text = UserInfo.share.nameUser
        
        if let imgProfile = URL(string: UserInfo.share.imgProfile)  {
            self.load(URL: imgProfile)
        }
        self.phoTo.image = UIImage(named: UserInfo.share.imgProfile)
        buttonDelete.clipsToBounds = true
        buttonDelete.layer.cornerRadius = buttonDelete.frame.height / 5
        buttonDelete.layer.shadowColor = UIColor.gray.cgColor
        buttonDelete.layer.shadowOffset = CGSize(width: 2, height: 3)
        buttonDelete.layer.shadowRadius = 24
        
        tableView_func.dataSource = self
        tableView_func.delegate = self
        
        
        dataQues1 = Database.database().reference().child("Users")
        dataQues = Database.database().reference().child("PlayHistory").child("109499177679521049079")
        let registerCell = UINib(nibName: "CellBackGround", bundle: nil)
        tableView_func.register(registerCell, forCellReuseIdentifier: "CellBackGround")
        let registerCell1 = UINib(nibName: "CellInfo", bundle: nil)
        tableView_func.register(registerCell1, forCellReuseIdentifier: "CellInfo")
        
    }
    
    @IBAction func actionDelete(_ sender: Any) {
        let alert = UIAlertController(title: "You really want to delete this account ?", message:"", preferredStyle: .alert)
        let alert1 = UIAlertAction(title: "Cancel", style: .default)
        let alert2 = UIAlertAction(title: "Yes", style: .default){(action) in
            if let userID = UserDefaults.standard.string(forKey: "currentID") {
                // xoa User trong database với ID đó
                self.dataQues1.child(userID).removeValue()
                
                self.navigationController?.pushViewController(ViewLogin(), animated: true)
            }
        }
        alert.addAction(alert1)
        alert.addAction(alert2)
        self.present(alert, animated: true,completion: nil)
    }
}
extension ViewProFile: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inFo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row <= 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellInfo",for: indexPath) as! CellInfo
            cell.label_1.text = inFo[indexPath.row]
            cell.backgroundColor = .clear
            if checkColor {
                cell.label_1.textColor = .white
            }else{
                
                cell.label_1.textColor = .black
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellBackGround",for: indexPath) as! CellBackGround
            cell.backgroundColor = .clear
            cell.switch_1.isOn = checkColor
            cell.label_1.text = inFo[indexPath.row]
            cell.switch_1.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            if cell.switch_1.isOn {
                cell.label_1.textColor = .white
            }else{
                
                cell.label_1.textColor = .black
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let alert = UIAlertController(title: "", message: inFo[indexPath.row], preferredStyle: .actionSheet)
            let alert1 = UIAlertAction(title: "Change Photo", style: .default) {(action) in
                let imgPicker = UIImagePickerController()
                imgPicker.sourceType = .photoLibrary
                imgPicker.delegate = self
                self.present(imgPicker, animated: true, completion: nil)
                
            }
            let alert2 = UIAlertAction(title: "Change Name Account", style: .default) {(action) in
                
                let alertx = UIAlertController(title: "", message: "New Name Account", preferredStyle: .alert)
                alertx.addTextField { textField in
                    textField.placeholder = "\(self.name_1.text ?? "")"
                    
                }
                
                let alertx_1 = UIAlertAction(title: "Save", style: .default) {(action) in
                    let text = alertx.textFields![0] as UITextField
                    UserInfo.share.nameUser = text.text ?? ""
                    self.name_1.text = UserInfo.share.nameUser
                    if let userID = UserDefaults.standard.string(forKey: "currentID") {
                        // thay ten vào database với ID đó
                        self.dataQues1.child(userID).updateChildValues(["nameUser": UserInfo.share.nameUser])
                    } else {
                        print("User ID not found")
                    }
                }
                let alertx_2 = UIAlertAction(title: "Cancel", style: .default) {(action) in }
                alertx.addAction(alertx_2)
                alertx.addAction(alertx_1)
                
                self.present(alertx, animated: true,completion: nil)
            }
            let alert3 = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(alert1)
            alert.addAction(alert2)
            alert.addAction(alert3)
            self.present(alert, animated: true,completion: nil)
            
        }
        if indexPath.row == 1{
            let alert = UIAlertController(title: "Total number of attempt", message: "\(UserInfo.share.totalNumberAttempt)", preferredStyle: .alert)
            let alert3 = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(alert3)
            self.present(alert, animated: true,completion: nil)
        }
        if indexPath.row == 2{
            let alert = UIAlertController(title: "Last time to do the test", message: UserInfo.share.lastTimetoDoTest, preferredStyle: .alert)
            let alert3 = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(alert3)
            self.present(alert, animated: true,completion: nil)
        }
        
        tableView_func.deselectRow(at: indexPath, animated: true)
    }
    @objc func switchChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            view.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
            self.tableView_func.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
            self.name_1.textColor = .white
            self.textProfile.textColor = .white
            checkColor = true
            self.buttonDelete.backgroundColor = #colorLiteral(red: 0, green: 0.2862745098, blue: 0.3058823529, alpha: 1)
        } else {
            self.textProfile.textColor = .black
            self.name_1.textColor = .black
            view.backgroundColor = .white
            self.tableView_func.backgroundColor = .white
            checkColor = false
            self.buttonDelete.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.8470588235, blue: 0.8156862745, alpha: 1)
        }
        tableView_func.reloadData()
    }
    func load(URL: URL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
            }
            else {
                print("Failure: %@", error.localizedDescription);
            }
            DispatchQueue.main.async {
                self.phoTo.image = UIImage(data: data)
            }
            
        })
        task.resume()
    }
}
extension ViewProFile: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        phoTo.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        //image kieu du lieu uiimage
        guard let imageData = phoTo.image?.pngData() else { return  }
        
        //lấy ds image (count) để + 1 khi add vào
        storage.listAll { storageListResult, er in
            guard er == nil else {
                print("loi khi lay du lieu")
                return
            }
            
            var number1: Int = storageListResult?.items.count ?? 0
            number1 += 1
            //đẩy data lên storage
            self.storage.child("Img\(number1)").putData(imageData, metadata: nil, completion: {data, error in
                guard error == nil else {
                    print("loi khi upload")
                    return
                }
                // tải url của ảnh
                self.storage.child("Img\(number1)").downloadURL(completion: {url, error in
                    guard let url = url, error == nil else { return  }
                    UserInfo.share.imgProfile = url.absoluteString
                    
                })
                
            })
        }
        // update url vừa tải vào data 
        DispatchQueue.main.asyncAfter(deadline: .now() + 10){
            if let userID = UserDefaults.standard.string(forKey: "currentID") {
                self.dataQues1.child(userID).updateChildValues(["imgProfile": UserInfo.share.imgProfile])
            } else {
                print("User ID not found")
            }
        }
        
    }
    
}
