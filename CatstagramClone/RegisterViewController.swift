//
//  RegisterViewController.swift
//  CatstagramClone
//
//  Created by 심지훈 on 2022/03/29.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK : - Properties
    
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
//    var passEmail: ((email) -> Void)? // 하나하나? = 비효율적
    
    var userInfo: ((UserInfo) -> Void)?
    

    // 유효성 검사를 위한 프로퍼티
    var isValidEmail = false{
        didSet{ // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    var isValidName = false{
        didSet{ // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    var isValidNickname = false{
        didSet{ // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    var isValidPassword = false{
        didSet{ // 프로퍼티 옵저버
            self.validateUserInfo()
        }
     }
    
    // TextFields
    
    @IBOutlet weak var popToLoginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    // 연산 프로퍼티 이용(배열)
    var textFields:[UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    // MARK - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        
        // bug fix 를 위한 코드 - 어떤 bug????
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
//        signupButton.layer.cornerRadius = 30 // 이렇게. 코드로 모서리를 둥글게 만들 수 있지만 UIView + Extension 에서 cornerRadius get, set 메소드를 설정하면 편하게 사용 가능
        
    }
    
    // MARK : Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField){ // IBAction 과 다른 방식
        let text = sender.text ?? ""
        
        switch sender{
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
        default:
            fatalError("Missing TextField...")
        }
        
        
    }
    

    // 가압 버튼
    @IBAction func registerButtonDidTapp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true) // 뒤로 가기
        // 이전 Scene Controller 에 데이터를 전달해줘야 함. (세그웨이 사용, 델리게이트 패턴 두가지 방식이 있음) 이번엔 closer 사용
        let userInfo = UserInfo(email: self.email, name: self.name, nickname: self.nickname, password: self.password)
        
        self.userInfo?(userInfo)
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        // 뒤로 가기
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK : Helpers
    private func setupTextField(){
        
//        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_sender:)), for: .editingChanged)

        
        // 위 코드들을 아래 forEach 사용해서 코드 길이 줄이기
        textFields.forEach{tf in tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)}
    }
    
    
    // 사용자가 입력한 회원정보를 확인하고 -> UI 업데이트
    private func validateUserInfo(){
        
        if isValidName && isValidNickname && isValidEmail && isValidPassword{
            self.signupButton.isEnabled = true
            UIView.animate(withDuration: 0.33){
                self.signupButton.backgroundColor = UIColor.facebookColor
            }
        }else{
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33){
                self.signupButton.backgroundColor = .disableButtonColor
            }
            
        }
        
    }

    private func setupAttribute(){
        // loginButton
        
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.popToLoginButton,
                                                 texts: text1,text2,
                                                 fonts: font1,font2,
                                                 colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }

}

// 정규표현식
extension String{
    //대소문자, 특수문자, 숫자 8자 이상일 때 -> True
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    // @ 2글자
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0--9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
}
