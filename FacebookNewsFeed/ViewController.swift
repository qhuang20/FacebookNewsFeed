//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Qichen Huang on 2017-12-14.
//  Copyright © 2017 Qichen Huang. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width, height: 300)
    }
    
}

class FeedCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "zuckprofile"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Meanwhile, Beast turned to the dark side"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "zuckdog"))
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        
        addConstraintsWithFormat(format: "H:|-[v0(44)]-[v1]-|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-4-[v0]-|", views: statusTextView)
        addConstraintsWithFormat(format: "V:|-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-[v0(44)]-4-[v1(30)]-4-[v2]|", views: profileImageView, statusTextView, statusImageView)
    }
    
}




