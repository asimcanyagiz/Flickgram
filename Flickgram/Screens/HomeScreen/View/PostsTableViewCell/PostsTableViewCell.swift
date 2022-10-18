//
//  PostsTableViewCell.swift
//  Flickgram
//
//  Created by Asım can Yağız on 15.10.2022.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    var indexNumber = 0
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    {
        didSet {
            likeButton.addTarget(self, action: #selector(PostsTableViewCell.mapsHit(_:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    @objc func mapsHit(_ sender: UIButton){
        indexNumber = sender.tag
        print("This button is at \(indexNumber) row")
        // get indexPath.row from cell
        // do something with it

    }
    
    
    
    
    //    @IBOutlet weak var titleLabel: UILabel!
    //    @IBOutlet weak var priceLabel: UILabel!
    
    
    //    var title: String? {
    //        set {
    //            titleLabel.text = newValue
    //        }
    //        get {
    //            titleLabel.text
    //        }
    //    }
    //
    //    var price: String? {
    //        didSet {
    //            priceLabel.text = price
    //        }
    //    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
