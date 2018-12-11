//
//  YQRestaurantCellTableViewCell.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/11/7.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

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
        super.init(coder: aDecoder)
    }
    
    func initUI() -> Void {
        
        thumbnailImageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 60, height: 60))
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width * 0.5
        thumbnailImageView.layer.masksToBounds = true
        self.addSubview(thumbnailImageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(nameLabel)
        
        locationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.addSubview(locationLabel)
        
        typeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.addSubview(typeLabel)
        
    }
    
    func setData(restaurant: Restaurant) {
        thumbnailImageView.image = UIImage(named: restaurant.name)
        
        nameLabel.text = restaurant.name
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: thumbnailImageView.frame.origin.x + thumbnailImageView.frame.size.width + 12, y: thumbnailImageView.frame.origin.y - 2, width: nameLabel.frame.size.width, height: nameLabel.frame.size.height)
        
        locationLabel.text = restaurant.location
        locationLabel.sizeToFit()
        locationLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.size.height, width: locationLabel.frame.size.width, height: locationLabel.frame.size.height)
        
        typeLabel.text = restaurant.type
        typeLabel.sizeToFit()
        typeLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: locationLabel.frame.origin.y + locationLabel.frame.size.height, width: typeLabel.frame.size.width, height: typeLabel.frame.size.height)
    }

}
