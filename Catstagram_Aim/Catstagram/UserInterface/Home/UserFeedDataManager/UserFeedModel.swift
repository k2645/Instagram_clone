//
//  UserFeedModel.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/25.
//

import Foundation

struct UserFeedModel : Decodable {
    // shift + control -> 멀티커서, option + 방향키 -> 단어별 넘김
    // control + i -> 코드 재정렬
    let isSuccess : Bool?
    let code : Int?
    let message : String?
    let result : UserFeedModelResult?
}

struct UserFeedModelResult : Decodable {
    let _isMyFeed : Bool?
    let getUserInfo : GetUserInfo?
    let getUserPosts : [GetUserPosts]?
}

struct GetUserInfo : Decodable {
    let userIdx : Int?
    let nickName : String?
    let name : String?
    let profileImgUrl : String?
    let website : String?
    let introduction : String?
    let followerCount : Int?
    let followingCount : Int?
    let postCount : Int?
}

struct GetUserPosts : Decodable {
    let postIdx : Int?
    let postImgUrl : String?
}
    
