//
//  PostsTableViewCell.swift
//  Flickgram
//
//  Created by Asım can Yağız on 15.10.2022.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    //Variable for save the indexnumber
    var indexNumber = 0
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    {
        didSet {
            //This button variable targeted to function its like a lazy var when you pressed function it will be call
            likeButton.addTarget(self, action: #selector(PostsTableViewCell.mapsHit(_:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    @IBOutlet weak var saveButton: UIButton!{
        didSet {
            //This button variable targeted to function its like a lazy var when you pressed function it will be call
            saveButton.addTarget(self, action: #selector(PostsTableViewCell.mapsHit(_:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    
    
    //When user pressed like or save button system saves indexnumber from tag HomeScreenViewController
    @objc func mapsHit(_ sender: UIButton){
        indexNumber = sender.tag
        sender.imageView?.image = UIImage(named: "hand.thumbsup.fill")

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    
    
}
