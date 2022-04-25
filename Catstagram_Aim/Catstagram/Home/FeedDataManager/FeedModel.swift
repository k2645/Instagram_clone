//
//  FeedModel.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/25.
//

// 서버에서 받아오는 역할
struct FeedModel : Decodable {
    // 변수명을 꼭! API의 parameter와 똑.같.이 적어줘야함
    var id : String?
    var url : String?
}
