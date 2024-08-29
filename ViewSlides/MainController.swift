//
//  MainController.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 10/4/24.
//

import UIKit

class MainController: UIViewController {
    var modelViewSlides =  ModelViewSlides()
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var Coll_slides: UICollectionView!
    @IBOutlet weak var coll_flowLayout: UICollectionViewFlowLayout!
    var test = true
    override func viewDidLoad() {
        super.viewDidLoad()
        Coll_slides.dataSource = self
        Coll_slides.delegate = self
        Coll_slides.contentOffset = CGPoint(x: 0, y: 0)
        coll_flowLayout.scrollDirection = .horizontal
        button_1.clipsToBounds = true
        button_1.layer.cornerRadius = button_1.frame.height / 2
        button_1.layer.shadowColor = UIColor.gray.cgColor
        button_1.layer.shadowOffset = CGSize(width: 2, height: 3)
        button_1.layer.shadowRadius = 24
        
        let registerCell = UINib(nibName: "SlidesCollectionViewCell", bundle: nil)
        Coll_slides.register(registerCell, forCellWithReuseIdentifier: "SlidesCollectionViewCell")
        Coll_slides.showsHorizontalScrollIndicator = false
    }
    @IBAction func button_2(_ sender: UIButton) {
        navigationController?.pushViewController(ViewLogin(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        test = false
    }
    
    func scrollViewDidScroll(_ Coll_slides1: UIScrollView) {
        if test {return}
        if Coll_slides1 === self.Coll_slides {
            if  Coll_slides1.contentOffset.x < 0 {
                Coll_slides1.contentOffset.x = 0
            } else if self.Coll_slides.bounds.width + Coll_slides1.contentOffset.x > Coll_slides1.contentSize.width {
                Coll_slides1.contentOffset.x = Coll_slides1.contentSize.width - self.Coll_slides.frame.width
            }
        }
    }

}
extension MainController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelViewSlides.img_slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidesCollectionViewCell",for: indexPath) as! SlidesCollectionViewCell
        cell.img_slides.image = UIImage(named: modelViewSlides.img_slides[indexPath.row])
        cell.label_slides_1.text = modelViewSlides.label1_slides[indexPath.row]
        cell.label_slides_2.text = modelViewSlides.label2_slides[0]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Coll_slides.frame.width, height: Coll_slides.frame.height)
    }
    
}
