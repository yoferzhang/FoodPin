//
//  YQRestaurantDetailIconTextCell.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/12.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
private struct Constants {
    static let marginOfLabel: CGFloat = 10
    static let leftMarginOfIconImage: CGFloat = 12
    static let topMarginOfLabel: CGFloat = 12
}

import UIKit

class YQRestaurantDetailIconTextCell: UITableViewCell {
    
    var iconImageView: UIImageView!
    var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() -> Void {
        
        iconImageView = UIImageView(frame: CGRect.zero)
        self.contentView.addSubview(iconImageView)
        
        detailLabel = UILabel(frame: CGRect.zero)
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.numberOfLines = 0
        self.contentView.addSubview(detailLabel)
        
    }
    
    func setData(imageName: String, detailText: String) {
        iconImageView.image = UIImage(named: imageName)
        iconImageView.sizeToFit()
        iconImageView.frame = CGRect(x: Constants.leftMarginOfIconImage, y: 0, width: iconImageView.frame.width, height: iconImageView.frame.height)
        iconImageView.center = CGPoint(x: iconImageView.center.x, y: self.contentView.frame.height * 0.5)
        
        detailLabel.text = detailText
        detailLabel.sizeToFit()
        let labelSize = detailLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - iconImageView.frame.maxX - Constants.marginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        detailLabel.frame = CGRect(x: iconImageView.frame.maxX + Constants.marginOfLabel, y: Constants.topMarginOfLabel, width: UIScreen.main.bounds.width - iconImageView.frame.maxX - Constants.marginOfLabel * 2, height: labelSize.height)
    }
    
    // MARK: - Helper Method
    /// 类方法返回cell的高
    class func heightForIconTextCell(image: Data, text: String) -> CGFloat {
        let iconImageView = UIImageView(frame: CGRect.zero)
        iconImageView.image = UIImage(data: image)
        iconImageView.sizeToFit()
        iconImageView.frame = CGRect(x: Constants.leftMarginOfIconImage, y: 0, width: iconImageView.frame.width, height: iconImageView.frame.height)

        
        let detailLabel = UILabel(frame: CGRect.zero)
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.text = text
        detailLabel.numberOfLines = 0
        let labelSize = detailLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - iconImageView.frame.maxX - Constants.marginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        
        
        return labelSize.height + Constants.topMarginOfLabel * 2
    }
}
