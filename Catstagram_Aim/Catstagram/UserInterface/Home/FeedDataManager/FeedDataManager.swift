//
//  FeedDataManager.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/25.
//


// 클라이언트와 서버를 연결해주는 역할
import Alamofire

class FeedDataManager {
    func feedDataManager(_ parameters : FeedAPIInput, _ viewController : HomeViewController) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
            switch response.result {
            case .success(let result):
                viewController.sucessAPI(result)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
