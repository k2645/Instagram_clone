//
//  PostCollectionViewCell.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/15.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"

    @IBOutlet weak var postImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func serupData() {
        // 이미지뷰의 이미지를 업로드.
    }
    
}
