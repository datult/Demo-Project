//
//  ViewQuestion.swift
//  DemoAppQuestion
//
//  Created by Van Thanh on 11/5/24.
//

import UIKit
import Firebase

class ViewQuestion: UIViewController,Delegate {
    
    @IBOutlet weak var stackViewBoundAll: UIStackView!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var cauHoi: UILabel!
    @IBOutlet weak var viewCauHoi: UIView!
    @IBOutlet weak var viewBoundDapAn: UIView!
    @IBOutlet weak var viewDapAn1: UIView!
    @IBOutlet weak var dapAn1: UILabel!
    @IBOutlet weak var checkBox_1: UIImageView!
    @IBOutlet weak var viewDapAn2: UIView!
    @IBOutlet weak var dapAn2: UILabel!
    @IBOutlet weak var checkBox_2: UIImageView!
    @IBOutlet weak var viewDapAn3: UIView!
    @IBOutlet weak var dapAn3: UILabel!
    @IBOutlet weak var checkBox_3: UIImageView!
    @IBOutlet weak var viewDapAn4: UIView!
    @IBOutlet weak var checkBox_4: UIImageView!
    @IBOutlet weak var dapAn4: UILabel!
    @IBOutlet weak var stackViewDapAn: UIStackView!
    @IBOutlet weak var buttonBack: UIImageView!
    @IBOutlet weak var viewCircle: UIView!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var cauHoiHienTai: UILabel!
    
    var presenter = PresenterViewQuestion()
    var time : Timer?
    var circleLayer = CAShapeLayer()
    var timeLeftt = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // presenter = PresenterViewQuestion()
        presenter.Delegate_1 = self
        self.timeLeft.font = UIFont(name: "Baloo2-SemiBold", size: 32)
        self.timeLeft.text = String(timeLeftt)
        setupCircle()
        StartTime()
        self.navigationController?.isNavigationBarHidden = true
        viewCauHoi.layer.cornerRadius = viewCauHoi.frame.height/6
        viewCauHoi.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewCauHoi.layer.shadowColor = CGColor(red: 0,
                                               green: 0,
                                               blue: 0,
                                               alpha: 0.15)
        viewCauHoi.layer.shadowOpacity = 1.0
        viewCauHoi.layer.shadowRadius = 2.0
        viewCauHoi.layer.masksToBounds = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        viewDapAn1.layer.cornerRadius = viewDapAn1.frame.height/3
        viewDapAn2.layer.cornerRadius = viewDapAn2.frame.height/3
        viewDapAn3.layer.cornerRadius = viewDapAn3.frame.height/3
        viewDapAn4.layer.cornerRadius = viewDapAn4.frame.height/3
        Button.clipsToBounds = true
        Button.layer.cornerRadius = Button.frame.height / 5
        Button.layer.shadowColor = UIColor.gray.cgColor
        Button.layer.shadowOffset = CGSize(width: 2, height: 3)
        Button.layer.shadowRadius = 24
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(answerPressed1))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(answerPressed2))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(answerPressed3))
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(answerPressed4))
        
        viewDapAn1.addGestureRecognizer(tapGesture1)
        viewDapAn2.addGestureRecognizer(tapGesture2)
        viewDapAn3.addGestureRecognizer(tapGesture3)
        viewDapAn4.addGestureRecognizer(tapGesture4)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        buttonBack.isUserInteractionEnabled = true
        buttonBack.addGestureRecognizer(tapGestureRecognizer)
        
        if presenter.cauSo  < presenter.allQues.count  {
            cauHoiHienTai.text = "\((presenter.cauSo)+1)/\(presenter.allQues.count)"
            showQuestion()
            updateQues()
        }
    }
    @objc func imageTapped(_ sender: UITapGestureRecognizer)
    {
        handelBack()
    }
    private func setupCircle() {
        viewCircle.backgroundColor = .clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(
            x:viewCircle.frame.size.width / 2.0,
            y: viewCircle.frame.size.height / 2.0),
                                      radius: (viewCircle.frame.size.width - 1.5)/2,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        let circleLayer1 = CAShapeLayer()
        circleLayer1.path = circlePath.cgPath
        viewCircle.layer.addSublayer(circleLayer1)
        circleLayer1.strokeColor = #colorLiteral(red: 0.6705882353, green: 0.8196078431, blue: 0.7764705882, alpha: 1)
        circleLayer1.fillColor = UIColor.clear.cgColor
        circleLayer1.lineWidth = 5
        
        circleLayer = CAShapeLayer()
        circleLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = #colorLiteral(red: 0, green: 0.2745098039, blue: 0.262745098, alpha: 1)
        circleLayer.lineWidth = 5
        circleLayer.strokeEnd = 0
        circleLayer.lineCap = .round
        
        viewCircle.layer.addSublayer(circleLayer)
        
    }
    
    private func animateCircle() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 30
        circleLayer.add(animation, forKey: "circleAnimation")
    }
    
    func StartTime(){
        time = Timer.scheduledTimer(timeInterval: 1,
                                    target: self,
                                    selector: #selector(timer),
                                    userInfo: nil,
                                    repeats: true)
        animateCircle()
    }
    
    func stopTime()  {
        time?.invalidate()
        time = nil
    }
    
    @objc func timer() {
        timeLeftt -= 1
        self.timeLeft.text = String(timeLeftt)
        if timeLeftt == 0{
            UIView.transition(with: viewCauHoi,
                              duration: 0.5,
                              options: .transitionCurlUp,
                              animations: {self.showQuestion()},
                              completion: nil)
            UIView.transition(with: viewBoundDapAn,
                              duration: 0.5,
                              options: .transitionCurlUp,
                              animations: {self.showQuestion()},
                              completion: nil)
            presenter.cauSo += 1
            animateCircle()
            updateQues()
            timeLeftt = 30
            viewDapAn2.backgroundColor = .white
            viewDapAn3.backgroundColor = .white
            viewDapAn1.backgroundColor = .white
            viewDapAn4.backgroundColor = .white
            checkBox_1.image = UIImage(named: "Ellipse3123")
            checkBox_4.image = UIImage(named: "Ellipse3123")
            checkBox_3.image = UIImage(named: "Ellipse3123")
            checkBox_2.image = UIImage(named: "Ellipse3123")
        }
    }
    
    func showQuestion() {
        cauHoi.font = UIFont(name: "Baloo2-SemiBold.ttf", size: 32)
        if presenter.cauSo < presenter.allQues.count{
            cauHoi.text = presenter.allQues[presenter.cauSo].cauHoi
        }
    }
    @objc func handelBack(){
        presenter.model.score = 0
        self.presenter.allQues.removeAll()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handelNext(_ sender: Any) {
        checkAnswer()
        if presenter.cauSo < presenter.allQues.count {
            UIView.transition(with: viewCauHoi,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: {self.showQuestion()},
                              completion: nil)
            UIView.transition(with: viewBoundDapAn,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: {self.showQuestion()},
                              completion: nil)
            presenter.cauSo += 1
            animateCircle()
            self.timeLeftt = 30
            updateQues()
        }
    }
    
    func updateQues() {
        if presenter.cauSo < presenter.allQues.count {
            let currentQuestion = presenter.allQues[presenter.cauSo]
            dapAn1.text = currentQuestion.dapAn[0]
            dapAn2.text = currentQuestion.dapAn[1]
            dapAn3.text = currentQuestion.dapAn[2]
            dapAn4.text = currentQuestion.dapAn[3]
            presenter.dapAnDung = currentQuestion.dADung
            cauHoi.text = currentQuestion.cauHoi
            cauHoiHienTai.text = "\((presenter.cauSo)+1)/\(String(describing: presenter.allQues.count))"
        }else{
            stopTime()
            presenter.addMember()
            let viewCongrat_1 = ViewCongrat()
            viewCongrat_1.score = self.presenter.model.score
            viewCongrat_1.totalQues = self.presenter.allQues.count
            navigationController?.pushViewController(viewCongrat_1, animated: true)
        }
    }

    func checkAnswer(){
        viewDapAn1.backgroundColor = .white
        viewDapAn2.backgroundColor = .white
        viewDapAn3.backgroundColor = .white
        viewDapAn4.backgroundColor = .white
        checkBox_1.image = UIImage(named: "Ellipse3123")
        checkBox_2.image = UIImage(named: "Ellipse3123")
        checkBox_3.image = UIImage(named: "Ellipse3123")
        checkBox_4.image = UIImage(named: "Ellipse3123")
//        if viTri == dapAnDung {
//            score += 1
//        }
        presenter.checkAnswer()
        
    }
    
    @objc func answerPressed1(_ sender: UITapGestureRecognizer){
        viewDapAn1.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.8196078431, blue: 0.7764705882, alpha: 1)
        viewDapAn2.backgroundColor = .white
        viewDapAn3.backgroundColor = .white
        viewDapAn4.backgroundColor = .white
        checkBox_1.image = UIImage(named: "Group41234")
        checkBox_2.image = UIImage(named: "Ellipse3123")
        checkBox_3.image = UIImage(named: "Ellipse3123")
        checkBox_4.image = UIImage(named: "Ellipse3123")
        presenter.model.thuTuDapAn = 0
    }
    
    @objc func answerPressed2(_ sender: UITapGestureRecognizer){
        viewDapAn2.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.8196078431, blue: 0.7764705882, alpha: 1)
        viewDapAn1.backgroundColor = .white
        viewDapAn3.backgroundColor = .white
        viewDapAn4.backgroundColor = .white
        checkBox_2.image = UIImage(named: "Group41234")
        checkBox_1.image = UIImage(named: "Ellipse3123")
        checkBox_4.image = UIImage(named: "Ellipse3123")
        checkBox_3.image = UIImage(named: "Ellipse3123")
        presenter.model.thuTuDapAn = 1
    }
    
    @objc func answerPressed3(_ sender: UITapGestureRecognizer){
        viewDapAn3.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.8196078431, blue: 0.7764705882, alpha: 1)
        viewDapAn2.backgroundColor = .white
        viewDapAn1.backgroundColor = .white
        viewDapAn4.backgroundColor = .white
        checkBox_3.image = UIImage(named: "Group41234")
        checkBox_1.image = UIImage(named: "Ellipse3123")
        checkBox_2.image = UIImage(named: "Ellipse3123")
        checkBox_4.image = UIImage(named: "Ellipse3123")
        presenter.model.thuTuDapAn = 2
    }
    
    @objc func answerPressed4(_ sender: UITapGestureRecognizer){
        viewDapAn4.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.8196078431, blue: 0.7764705882, alpha: 1)
        viewDapAn2.backgroundColor = .white
        viewDapAn3.backgroundColor = .white
        viewDapAn1.backgroundColor = .white
        checkBox_4.image = UIImage(named: "Group41234")
        checkBox_1.image = UIImage(named: "Ellipse3123")
        checkBox_2.image = UIImage(named: "Ellipse3123")
        checkBox_3.image = UIImage(named: "Ellipse3123")
        presenter.model.thuTuDapAn = 3
    }
    
}

