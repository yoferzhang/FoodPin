//
//  YQRestaurantEditPhotoCell.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/14.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

struct EditPhotoCellConstants {
    static let heightOfEditPhotoCell: CGFloat = 200

}

import UIKit

class YQRestaurantEditPhotoCell: UITableViewCell {
    
    var photoImageView: UIImageView!

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
        photoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: EditPhotoCellConstants.heightOfEditPhotoCell))
        photoImageView.backgroundColor = .lightGray
        contentView.addSubview(photoImageView)
    }
    
}
