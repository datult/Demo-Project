//
//  ViewControllerTest_1.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 21/6/24.
//

import UIKit

class ViewControllerTest_1: UIViewController{

    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var but_1: UIButton!
    @IBOutlet weak var label_1: UILabel!
    let view2: ViewControllerTest_2 = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewControllerTest_1 \(self)")

        label_1.text = "vnathanh"
        view2.speak = {x in
                print(x)
        }
        view2.hamTruyenClosure(name: view2.name) { ten in
            print("ham truyen closure \(ten)")
        }
    }

    @IBAction func handelNext(_ sender: Any) {
        view2.p = label_1.text ?? ""
       // view2.m.x = m.x
        //view2.delegate = self
        view2.speak = {x in
            self.label_2.text = x
        }
        navigationController?.pushViewController(view2, animated: true)
    }
    
   

}
