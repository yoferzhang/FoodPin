//
//  YQReataurantDetailTextCell.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/12.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
struct DetailTextCellConstants {
    static let leftMarginOfLabel: CGFloat = 12
    static let topMarginOfLabel: CGFloat = 10
}

import UIKit

class YQReataurantDetailTextCell: UITableViewCell {

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
        
        detailLabel = UILabel(frame: CGRect.zero)
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.numberOfLines = 0
        self.contentView.addSubview(detailLabel)
        
    }
    
    func setData(detailText: String) {

        detailLabel.text = detailText
        var labelSize = detailLabel.sizeThatFits(CGSize(width: self.contentView.frame.width - DetailTextCellConstants.leftMarginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        if (labelSize.height > self.contentView.frame.height - DetailTextCellConstants.topMarginOfLabel * 2) {
            labelSize.height = self.contentView.frame.height - DetailTextCellConstants.topMarginOfLabel * 2
        }
        
        detailLabel.frame = CGRect(x: DetailTextCellConstants.leftMarginOfLabel, y: DetailTextCellConstants.topMarginOfLabel, width: self.contentView.frame.width - DetailTextCellConstants.leftMarginOfLabel * 2, height: labelSize.height)
    }
}
