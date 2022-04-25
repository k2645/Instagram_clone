//
//  FeedAPIInput.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/25.
//

// 서버와 연동할 때 클라이언트가 보내주는 역할
struct FeedAPIInput : Encodable {
    var limit : Int?
    var page : Int?
}
