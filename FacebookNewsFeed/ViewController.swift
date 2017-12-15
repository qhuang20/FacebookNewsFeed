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
        
        return CGSize(width: view.bounds.width, height: 400)
    }
    
    //Orientation: Invalidates the current layout and triggers a layout update.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()//very simple!
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
        let secondLineText = NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)])
        attributedText.append(secondLineText)
        
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
    
    let likeCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes   10.7k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton = createButton(title: "Like", imageName: "like")
    let commentButton = createButton(title: "Comment", imageName: "comment")
    let shareButton = createButton(title: "Share", imageName: "share")
    
    static func createButton(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likeCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        addConstraintsWithFormat(format: "H:|-[v0(44)]-[v1]-|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-4-[v0]-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-|", views: likeCommentsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat(format: "H:|[v0(v1)][v1][v2(v1)]|", views: likeButton, commentButton, shareButton)//"H:|[v0(v2)][v1(v2)][v2]|" equal space
        
        
        addConstraintsWithFormat(format: "V:|-[v0(48)]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-[v0(44)]-4-[v1(30)]-4-[v2]-[v3(24)]-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likeCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)

    }
    
}




