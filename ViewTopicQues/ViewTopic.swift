//
//  ViewTopic.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 3/5/24.
//

import UIKit
import Firebase

enum ViTri: Int {
    case viTri1 = 0
    case viTri2 = 1
    case viTri3 = 2
    
}
class ViewTopic: UIViewController  {
    static func newTopic() -> ViewTopic{
        return ViewTopic()
    }
    
    @IBOutlet weak var viewPathContraintLeft: NSLayoutConstraint!
    @IBOutlet weak var menuClasses: UILabel!
    @IBOutlet weak var menuStudied: UILabel!
    @IBOutlet weak var menuCreated: UILabel!
    @IBOutlet weak var viewBoundpath: UIView!
    @IBOutlet weak var viewPath: UIView!
    @IBOutlet weak var tableView_1: UITableView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var createAcc: UILabel!
    
    private let viewTopic_1 = ViewTopicInPV()
    private let viewHistory_1 = ViewHistory()
    private let viewRank_1 = ViewRank()
    private var pageController = UIPageViewController()
    private var subViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViewControllers = [viewTopic_1,viewHistory_1,viewRank_1]
        self.navigationItem.title = "Add sets"
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
        menuCreated.isUserInteractionEnabled = true
        menuStudied.isUserInteractionEnabled = true
        menuClasses.isUserInteractionEnabled = true
        menuCreated.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelMenuCreated(_:))))
        menuStudied.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelMenuStudied(_:))))
        menuClasses.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelMenuClasses(_:))))
        setupPageController()
        
        
        
        
    }
    private func setupPageController() {
            self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            self.pageController.dataSource = nil
            self.pageController.delegate = nil
            self.pageController.view.backgroundColor = .clear
            self.pageController.view.frame = CGRect(x: 0,y: 0,width: pageView.frame.width,height: pageView.frame.height)
            self.pageController.setViewControllers([subViewControllers[0]], direction: .forward, animated: false, completion: nil)
            self.addChild(self.pageController)
            self.pageView.addSubview(self.pageController.view)
            self.pageController.didMove(toParent: self)
    }
    func putView(_ m: ViTri) {
        switch m {
        case .viTri1:
            viewPathContraintLeft.constant = 0
            self.pageController.setViewControllers([subViewControllers[m.rawValue]], direction: .forward, animated: false, completion: nil)
        case .viTri2:
            viewPathContraintLeft.constant = 93
            (subViewControllers[m.rawValue] as? ViewHistory)?.presenter?.email_1 = UserInfo.share.nameUser
            self.pageController.setViewControllers([subViewControllers[m.rawValue]], direction: .forward, animated: false, completion: nil)
        case .viTri3:
            viewPathContraintLeft.constant = 191
            self.pageController.setViewControllers([subViewControllers[m.rawValue]], direction: .forward, animated: false, completion: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPageController()
    }
    @objc func handelMenuCreated(_ sender: UITapGestureRecognizer) {
        putView(.viTri1)
    }
    @objc func handelMenuStudied(_ sender: UITapGestureRecognizer) {
        putView(.viTri2)
    }
    @objc func handelMenuClasses(_ sender: UITapGestureRecognizer) {
        putView(.viTri3)
    }
    
}
