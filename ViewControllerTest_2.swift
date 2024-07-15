//
//  ViewControllerTest_2.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 21/6/24.
//

//screen A -> B show leen man hinhf
//screen B -> A (data B) leen man hinhf


import UIKit

class ViewControllerTest_2: UIViewController {
    //var delegate: UICollectionViewDelegate1?
    @IBOutlet weak var but_1: UIButton!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_1: UILabel!
    var speak: ((String) -> Void)?
//    var m = DataEvent(x: "", y: "yyyyyyy")
    var p: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewControllerTest_2 \(self)")
        //self.delegate?.test(x: p,y: "xxxxxxx")
        self.speak?("xxxxxxx")
        label_1.text = p
        label_2.text = "xxxxxxx"
    }


    @IBAction func handelBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
