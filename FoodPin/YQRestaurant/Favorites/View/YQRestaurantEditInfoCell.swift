//
//  YQRestaurantEditInfoCell.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/14.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
private struct EditInfoCellConstants {
    static let leftMarginOfLabel: CGFloat = 12
    static let topMarginOfLabel: CGFloat = 10
    static let marginOfLabelAndTextField: CGFloat = 10
}

import UIKit

class YQRestaurantEditInfoCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var textField: YQRoundedTextField!
    
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
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() -> Void {
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        
        textField = YQRoundedTextField(frame: CGRect.zero)
        textField.borderStyle = .none
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        textField.backgroundColor = UIColor.lightGray
        textField.contentVerticalAlignment = .top
        contentView.addSubview(textField)
    }
    
    func configure(title: String, placeholder: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: EditInfoCellConstants.leftMarginOfLabel, y: EditInfoCellConstants.topMarginOfLabel, width: UIScreen.main.bounds.width - EditInfoCellConstants.leftMarginOfLabel * 2, height: titleLabel.frame.height)
        
        textField.placeholder = placeholder
        textField.frame = CGRect(x: EditInfoCellConstants.leftMarginOfLabel, y: titleLabel.frame.maxY + EditInfoCellConstants.marginOfLabelAndTextField, width: UIScreen.main.bounds.width - EditInfoCellConstants.leftMarginOfLabel * 2, height: contentView.frame.height - titleLabel.frame.maxY - EditInfoCellConstants.marginOfLabelAndTextField * 2)
    }
    
}
