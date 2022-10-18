//
//  PhotoTableViewCell.swift
//  Flickgram
//
//  Created by Asım can Yağız on 18.10.2022.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            titleLabel.text
        }
    }
    
    var price: String? {
        didSet {
            priceLabel.text = price
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet private(set) weak var iconImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
}
