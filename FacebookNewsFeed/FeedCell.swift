//
//  FeedCell.swift
//  FacebookNewsFeed
//
//  Created by Qichen Huang on 2017-12-18.
//  Copyright © 2017 Qichen Huang. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            
            guard let name = post?.name else { return }
            
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            if let city = post?.location?.city, let state = post?.location?.state {
                let secondLineText = NSAttributedString(string: "\nDecember 18 • \(city), \(state) • ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)])
                
                attributedText.append(secondLineText)
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "globe_small")
            attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
            attributedText.append(NSAttributedString(attachment: attachment))
            
            nameLabel.attributedText = attributedText
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }

            if let numLikes = post?.numLikes, let numComments = post?.numComments {
                likeCommentsLabel.text = "\(numLikes) Likes  \(numComments) Comments"
            }
            
        }
    }
    
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
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "zuckdog"))
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true//imageView.clipsToBounds = true
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
     
        return imageView
    }()
    
    //https://www.youtube.com/watch?v=kzdI2aiTX4k&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=6
    let blackView = UIView()
    let zoomImageView = UIImageView()
    let tabBarCover = UIView()
    let navBarCover = UIView()
    
    @objc func animate() {
        guard let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) else { return }//receiver’s coordinate system.convert
        
        guard let windowView = UIApplication.shared.keyWindow else { return }//see url
        
        guard let baseView = superview?.superview else { return }//UIViewController's view
        
        statusImageView.alpha = 0//hide it
        
        blackView.frame = windowView.frame
        blackView.backgroundColor = .black
        blackView.alpha = 0
        baseView.addSubview(blackView)
        
        zoomImageView.frame = startingFrame
        zoomImageView.contentMode = .scaleAspectFill
        zoomImageView.clipsToBounds = true
        zoomImageView.isUserInteractionEnabled = true
        baseView.addSubview(zoomImageView)
        
        tabBarCover.frame = CGRect(x: 0, y: 0, width: 1000, height: 44 + 20)
        tabBarCover.backgroundColor = .black
        tabBarCover.alpha = 0
        windowView.addSubview(tabBarCover)
        
        navBarCover.frame = CGRect(x: 0, y: windowView.frame.height - 49, width: 1000, height: 49)
        navBarCover.backgroundColor = .black
        navBarCover.alpha = 0
        windowView.addSubview(navBarCover)
        
        zoomImageView.image = statusImageView.image
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            let height = (windowView.frame.width / startingFrame.width) * startingFrame.height
            
            let y = windowView.frame.height / 2 - height / 2
            
            self.zoomImageView.frame = CGRect(x: 0, y: y, width: windowView.frame.width, height: height)
            
            self.blackView.alpha = 1
            self.navBarCover.alpha = 1
            self.tabBarCover.alpha = 1
        }, completion: nil)
    }
    
    @objc func zoomOut() {
        let startingFrame = statusImageView.superview!.convert(statusImageView.frame, to: nil)
        
        UIView.animate(withDuration: 0.75, animations: {
            self.zoomImageView.frame = startingFrame
            self.blackView.alpha = 0
            self.navBarCover.alpha = 0
            self.tabBarCover.alpha = 0
            
        }) { (didComplete) in
            self.zoomImageView.removeFromSuperview()
            self.blackView.removeFromSuperview()
            self.navBarCover.removeFromSuperview()
            self.tabBarCover.removeFromSuperview()
            self.statusImageView.alpha = 1
        }
    }
    
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
        
        addConstraintsWith(format: "H:|-[v0(44)]-[v1]-|", views: profileImageView, nameLabel)
        addConstraintsWith(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWith(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWith(format: "H:|-12-[v0]|", views: likeCommentsLabel)
        addConstraintsWith(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWith(format: "H:|[v0(v1)][v1][v2(v1)]|", views: likeButton, commentButton, shareButton)//"H:|[v0(v2)][v1(v2)][v2]|" equal space
        
        //8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
        addConstraintsWith(format: "V:|-[v0(48)]", views: nameLabel)
        addConstraintsWith(format: "V:|-[v0(44)]-4-[v1]-4-[v2(200)]-[v3(24)]-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likeCommentsLabel, dividerLineView, likeButton)
        addConstraintsWith(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWith(format: "V:[v0(44)]|", views: shareButton)
        
    }
    
}



