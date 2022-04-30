//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/30.
//

import Foundation

struct DeleteUserFeed: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result : String?
}
