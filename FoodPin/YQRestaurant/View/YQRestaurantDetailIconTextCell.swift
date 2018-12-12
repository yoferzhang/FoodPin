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
        self.contentView.addSubview(detailLabel)
        
    }
    
    func setData(imageName: String, detailText: String) {
        iconImageView.image = UIImage(named: imageName)
        iconImageView.sizeToFit()
        iconImageView.frame = CGRect(x: 12, y: 0, width: iconImageView.frame.width, height: iconImageView.frame.height)
        iconImageView.center = CGPoint(x: iconImageView.center.x, y: self.contentView.frame.height * 0.5)
        
        detailLabel.text = detailText
        detailLabel.sizeToFit()
        detailLabel.frame = CGRect(x: iconImageView.frame.maxX + Constants.marginOfLabel, y: 0, width: self.contentView.frame.width - iconImageView.frame.maxX - Constants.marginOfLabel * 2, height: detailLabel.frame.height)
        detailLabel.center = CGPoint(x: detailLabel.center.x, y: iconImageView.center.y)
    }

}
