//
//  FeedUploadModel.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/25.
//

struct FeedUploadModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : FeedUploadResult?
}

struct FeedUploadResult : Decodable {
    var postIdx : Int?
}
