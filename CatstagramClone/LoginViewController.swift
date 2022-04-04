//
//  LoginViewController.swift
//  CatstagramClone
//
//  Created by 심지훈 on 2022/03/28.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate { // UITextFieldDelegate '채택'하기
    
    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // Delegate
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var enteredLabel: UILabel!
    
    @IBAction func buttonClicked(_ sender: Any) {
        enteredLabel.text = textField.text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // delegate
        textField.delegate = self   // 위임자(대리자)가 누구인지 알려주는 과정
        // textField의 뒷바라지는 내(self : 현재클래스 LoginViewController)가 할게
        // 너에게 이벤트가 발생하면 프로토콜에 따라 너에게 응답을 줄게
        
        
        

    }
    
    // ------------------MARK - Actions ------------------
    

    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true) // 화면을 터치하면 단말기 키보드가 아래로 사라짐.
        }
    
    
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        //옵셔널 : 값이 있을 수도 있고 없을 수도 있는 type
        let text = sender.text ?? "" // 기본값을 주어서 optional 을 해제한 경우
        self.email = text
        
//        if text.isValidEmail() {
//            self.loginButton.backgroundColor = .facebookColor
//        }else{
//            self.loginButton.backgroundColor = .disableButtonColor
//        }
        
        self.loginButton.backgroundColor = text.isValidEmail() ? .facebookColor : .disableButtonColor
        
    }
    
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? "" // 기본값을 주어서 optional 을 해제한 경우
        
        self.loginButton.backgroundColor = text.count > 2 ? .facebookColor : .disableButtonColor
        
        self.password = text
        
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        print("loginButtonDidTap")
        // 회원가입 정보를 전달받아서 그것과 textField 데이터가 일치하면 로그인
        guard let userInfo = self.userInfo else { return }
        if userInfo.email == self.email
            && userInfo.password == self.password {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            
            print("다음 화면으로 이동")
            
        } else {
            
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        print("registerButtonDidTap")
        // 화면 전환
        
        // 1 스토리보드를 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2 뷰 컨트롤러를 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        
        // 3 화면전환 메소드를 이용해서 화면 전환
//        self.present(registerViewController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(registerViewController, animated: true) // -> 버튼 클릭 시 좌우로 나타탐 네비게이션 컨트롤러의 푸쉬
        
        registerViewController.userInfo = { [weak self] (userInfo) in
            self?.userInfo = userInfo
        }   // 참조에 대한 문제가 생길 수 있어 [weak self] : 약한 참조 : ARC를 낮춰주어 메모리가 해제되면 참조도 해제되도록 만들기 -> ARC 개념
        
        
    }
    
    
    
    @IBAction func testButton(_ sender: UIButton) {
        print("testButton 클리")
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

    


    
    // ------------------MARK - Helper ------------------
    private func setupAttribute(){
        // registerButton
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.registerButton,
                                                 texts: text1,text2,
                                                 fonts: font1,font2,
                                                 colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredLabel.text = textField.text
        return true
    }
    
    
    
    
}
