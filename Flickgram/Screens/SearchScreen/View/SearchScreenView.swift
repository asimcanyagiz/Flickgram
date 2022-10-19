////
////  SearchScreenView.swift
////  Flickgram
////
////  Created by Asım can Yağız on 16.10.2022.
////
//
//import UIKit
//
//final class SearchScreenView: UIView {
//    // MARK: - Properties
//    private let cellInset: CGFloat = 8.0
//    private let cellMultiplier: CGFloat = 0.5
//    private var cellDimension: CGFloat {
//        .screenWidth * cellMultiplier - cellInset
//    }
//
//    private lazy var flowLayout: UICollectionViewFlowLayout = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: cellDimension,
//                                     height: cellDimension)
//        return flowLayout
//    }()
//
//    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//
//    // MARK: - Init
//    init() {
//        super.init(frame: .zero)
//        backgroundColor = .gray
//
//        collectionView.register(SearchScreenTableViewCell.self, forCellWithReuseIdentifier: "cell")
//        setupCollectionViewLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Methods
//    private func setupCollectionViewLayout() {
//        addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
//    }
//
//    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate,
//                                   andDataSource dataSource: UICollectionViewDataSource) {
//        collectionView.delegate = delegate
//        collectionView.dataSource = dataSource
//    }
//
//    func refresh() {
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
//    }
//}
