//
//  YQRestaurantCellTableViewCell.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

// Swift 添加常量的方法
private struct Constants {
    static let marginOfLabel: CGFloat = 12
}

import UIKit

class YQRestaurantCellTableViewCell: UITableViewCell {


    var restaurantNeme: String!
    
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var typeLabel: UILabel!
    var thumbnailImageView: UIImageView!
    
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
        
        thumbnailImageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 60, height: 60))
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width * 0.5
        thumbnailImageView.layer.masksToBounds = true
        self.contentView.addSubview(thumbnailImageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.contentView.addSubview(nameLabel)

        
        locationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.contentView.addSubview(locationLabel)

        
        typeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.contentView.addSubview(typeLabel)

    }
    
    func setData(restaurant: RestaurantMO) {
        if let restaurantImage = restaurant.image {
            thumbnailImageView.image = UIImage(data: restaurantImage as Data)
        }
        
        let labelWidth = self.bounds.width - thumbnailImageView.frame.maxX - Constants.marginOfLabel - Constants.marginOfLabel;
        
        nameLabel.text = restaurant.name
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: thumbnailImageView.frame.origin.x + thumbnailImageView.frame.size.width + Constants.marginOfLabel, y: thumbnailImageView.frame.origin.y - 2, width: labelWidth, height: nameLabel.frame.size.height)
        
        locationLabel.text = restaurant.location
        locationLabel.sizeToFit()
        locationLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.size.height, width: labelWidth, height: locationLabel.frame.size.height)
        
        typeLabel.text = restaurant.type
        typeLabel.sizeToFit()
        typeLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: locationLabel.frame.origin.y + locationLabel.frame.size.height, width: labelWidth, height: typeLabel.frame.size.height)
    }

}
