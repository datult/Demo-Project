//
//  ViewTabbar.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 21/7/24.
//

import UIKit

class ViewTabbar: UITabBarController {
    var subView:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [ViewTopic(),
                                ViewQuestion(),
                                ViewProFile(),
                                ViewCongrat()]
        self.viewControllers = [ViewTopic(),ViewProFile()]
        viewControllers?[0].tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "folder"), selectedImage: UIImage(systemName: "folder.fill"))
        
        viewControllers?[1].tabBarItem = UITabBarItem(title: "profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
//        viewControllers?[2].tabBarItem = UITabBarItem(title: "Find", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash"))
//        viewControllers?[3].tabBarItem = UITabBarItem(title: "back", image: UIImage(systemName: "arrowshape.backward"), selectedImage:UIImage(systemName: "arrowshape.backward.fill"))
//        self.navigationItem.setHidesBackButton(true, animated: true)

        self.selectedIndex = 0
        
        
    }


   

}
