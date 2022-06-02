//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by 김영현 on 2022/05/13.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    // player의 크기를 담당하는 객체
    var playerLayer: AVPlayerLayer?
    // 반복재생에 관련된 객체
    var playerLooper: AVPlayerLooper?
    // 먼저 들어온 영상을 먼저 실행하고 나중에 들어온 영상을 나중에 실행시키는 순서에 관한 객체
    var queuePlayer: AVQueuePlayer?
    var urlStr: String
    
    init(frame: CGRect, urlStr: String) {
        self.urlStr = urlStr
        super.init(frame: frame)
        
        // file 불러오기
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL)
        
        // player 세팅
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        // player 화면을 크기가 꽉차게 설정
        playerLayer!.player = queuePlayer
        playerLayer!.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer!)
        
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 메모리 해제 함수
    public func cleanup() {
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil
    }
    
    // layout이 업데이트가 될 때마다 player의 frame을 현재 layout의 bound와 맞춰줌
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds
    }

}
