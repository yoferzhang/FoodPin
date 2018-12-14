//
//  YQRestaurantReviewViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/14.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
private struct ReviewViewControllerConstants {
    static let leftMarginOfCloseButton: CGFloat = 20
    static let widthOfCloseButton: CGFloat = 22
    static let numberOfRateButtons = 5
    static let leftMarginOfRateButton: CGFloat = 60
}

import UIKit

protocol YQRestaurantReviewViewControllerDelegate {
    // Classes that adopt this protocol MUST define
    // this method -- and hopefully do something in
    // that definition.
    func onClickRateButtonInReviewVC(rate: RateModel)
    
}

class YQRestaurantReviewViewController: UIViewController {

    var delegate: YQRestaurantReviewViewControllerDelegate!
    
    var restaurant: Restaurant!
    var backgroundImageView: UIImageView!
    var closeButton: UIButton!
    var rateButoons: Array<UIButton>!
    var rateModels: Array<RateModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initData()
        initializeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var interval:TimeInterval = 0.1
        for index in 0...self.rateButoons!.count - 1 {
            UIView.animate(withDuration: 2.0, delay: interval, options:[], animations: {
                let button = self.rateButoons[index]
                button.alpha = 1.0
                button.transform = .identity
            }, completion: nil)
            interval += 0.1
        }

    }
    
    func initData() {
        rateModels = Array()

        do {
            let rateModel = RateModel(title: "Love", image: "love")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Cool", image: "cool")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Happy", image: "happy")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Sad", image: "sad")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Angry", image: "angry")
            rateModels.append(rateModel)
        }
    }
    
    func initializeView() {
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImageView.image = UIImage(named: restaurant.name)
        
        // 加一个毛玻璃效果
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        view.addSubview(backgroundImageView)
        
        closeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - ReviewViewControllerConstants.leftMarginOfCloseButton - ReviewViewControllerConstants.widthOfCloseButton, y: 30, width: ReviewViewControllerConstants.widthOfCloseButton, height: ReviewViewControllerConstants.widthOfCloseButton))
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.addTarget(self, action: #selector(YQRestaurantReviewViewController.onClickCloseButton(recognizer:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        rateButoons = Array()
        var maxY: CGFloat = 80.0
        let moveRightTransForm = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        let scaleUpTransform = CGAffineTransform(scaleX: 5.0, y: 1.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransForm)
        
        for index in 0...rateModels.count - 1 {
            let rateButton = UIButton(frame: CGRect(x: ReviewViewControllerConstants.leftMarginOfRateButton, y: maxY, width: UIScreen.main.bounds.width - ReviewViewControllerConstants.leftMarginOfRateButton * 2, height: 60.0))
            let rateModel = rateModels[index]
            rateButton.setTitle(rateModel.title, for: .normal)
            rateButton.setImage(UIImage(named: rateModel.image), for: .normal)
            rateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            rateButton.sizeToFit()
            rateButton.alpha = 0
            rateButton.transform = moveScaleTransform
            rateButton.tag = index
            rateButton.addTarget(self, action: #selector(YQRestaurantReviewViewController.onClickRateButton(view:)), for: .touchUpInside)
            
            rateButoons.append(rateButton)
            view.addSubview(rateButton)
            
            maxY = rateButton.frame.maxY + 20
        }
    }

    //MARK: - 点击事件
    @objc func onClickCloseButton(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickRateButton(view: UIView) {
        if view.isKind(of: UIButton.self) {
            self.delegate?.onClickRateButtonInReviewVC(rate: self.rateModels[view.tag])
        }
        self.dismiss(animated: true, completion: nil)
    }

}
