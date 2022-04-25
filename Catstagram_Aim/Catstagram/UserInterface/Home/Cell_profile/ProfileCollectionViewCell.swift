//
//  ProfileCollectionViewCell.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/14.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    static let identifier = "ProfileCollectionViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var addProfileImageView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    @IBOutlet weak var postingCountLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupAttribute()
    }

    private func setupAttribute() {
        profileImageView.layer.cornerRadius = 88 / 2
        addProfileImageView.layer.cornerRadius = 24 / 2
        
        // shift + option key => 원하는 변수들 한번에 선택가능
        // profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        // profileImageView.layer.borderWidth = 1
        
        // boarder line 주기.
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor
        // core graphic이라는 low level의 라이브러리가 존재
        editButton.layer.borderWidth = 1
        
        addFriendButton.layer.cornerRadius = 3
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor
        addFriendButton.layer.borderWidth = 1
        
        // forEach문 => 반복문: 배열 내의 모든 것을 반복한다는 반복문.
        [postingCountLabel, followerCountLabel, followingCountLabel]
            .forEach { $0.text = "\(Int.random(in: 0...10))"}
        
    }
    
}
