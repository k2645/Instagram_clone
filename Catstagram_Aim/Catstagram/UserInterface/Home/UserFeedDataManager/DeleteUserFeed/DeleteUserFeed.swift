//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by κΉμν on 2022/04/30.
//

import Foundation

struct DeleteUserFeed: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result : String?
}
