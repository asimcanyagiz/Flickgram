//
//  SearchScreenTableViewCell.swift
//  Flickgram
//
//  Created by Asım can Yağız on 16.10.2022.
//

import UIKit

class SearchScreenTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
//    var image: UIImage? {
//        didSet {
//            imageView.image = image
//        }
//    }
//
//    var title: String? {
//        didSet {
//            titleLabel.text = title
//        }
//    }
//
//    private lazy var gradientLayer: CAGradientLayer = {
//        let layer = CAGradientLayer()
//        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
//        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        layer.locations = [0.0, 1.0]
//        return layer
//    }()
//
//    private(set) lazy var imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 8.0
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 21.0)
//        label.textColor = .white
//        label.numberOfLines = .zero
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
//
//        imageView.addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16.0),
//            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.0),
//            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8.0)
//        ])
//
//        imageView.layer.insertSublayer(gradientLayer, at: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = bounds
//    }
}
