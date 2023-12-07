//
//  AuthViewController.swift
//  telegramClone
//
//  Created by Egor Rybin on 19.06.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var tapGest: UITapGestureRecognizer?
    var checkField = CheckField.shared
    var service = Service.shared
    var UserDefault = UserDefaults.standard
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }

    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func openRegVC(_ sender: Any) {
        delegate.closeVC()
        delegate.openRegVC()
    }
    
    @IBAction func clickAithBtn(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField){
            service.authInApp(LoginField(email: emailField.text!, password: passwordField.text!)) { [weak self] response in
                switch response {
                case .success:
                    //print("next")
                    self?.UserDefault.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()
                case .noVerify:
//                    self?.UserDefault.set(true, forKey: "isLogin")
//                    self?.delegate.startApp()
//                    self?.delegate.closeVC()
                    let alert = self?.alertAction("noVerify", "To verify your acc")
                    let verifyBtn = UIAlertAction(title: "Ok", style: .cancel)
                    alert?.addAction(verifyBtn)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertAction("error", "ups error...")
                    let errorBtn = UIAlertAction(title: "Ok", style: .default)
                    alert?.addAction(errorBtn)
                    self?.present(alert!, animated: true)
                }
            }
        } else {
            let alert = self.alertAction("error", "no data, please sign up")
            let errorBtn = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(errorBtn)
            self.present(alert, animated: true)
        }
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController{
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    
    @IBAction func forgetPass(_ sender: Any) {
        //
    }
    
}
