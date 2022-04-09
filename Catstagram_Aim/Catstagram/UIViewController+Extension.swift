//
//  UIViewController+Extension.swift
//  Catstagram
//
//  Created by 김영현 on 2022/03/28.
//

import UIKit

extension UIViewController {
    func generateButtonAttribute(_ button: UIButton,
                                 texts: String..., // ...은 파라미터를 복수개로 받을 수 있음을 나타냄
                                 fonts: UIFont...,
                                 colors: UIColor...) -> NSMutableAttributedString { // 어떤 속성이 적용된 상태로 리턴한다.
        // UIButton에 입력된 text를 가져온다.
        guard let wholeText = button.titleLabel?.text else { fatalError("버튼에 텍스트가 없음.") }
        
        // 폰트들
        let customFonts: [UIFont] = fonts
        
        //설정하고자 하는 String의 NSRanges
        let customTextRanges = texts.indices.map { index in
            (wholeText as NSString).range(of: texts[index])
        }
        
        //설정하고자 하는 색상들
        let customColors = colors
        
        //attribute 객체를 생성한다.
        let attributedString = NSMutableAttributedString(string: wholeText)
        
        //텍스트에 맞는 설정을 추가한다.
        texts.indices.forEach{ index in
            attributedString.addAttribute(.font,
                                           value: customFonts[index],
                                           range: customTextRanges[index])
            attributedString.addAttribute(.foregroundColor,
                                          value: customColors[index],
                                          range: customTextRanges[index])
        }
        return attributedString
    }
}
