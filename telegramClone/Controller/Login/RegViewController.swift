//
//  RegViewController.swift
//  telegramClone
//
//  Created by Egor Rybin on 19.06.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    
    @IBOutlet weak var mainView: UIView!
    
    var tapGest: UITapGestureRecognizer?
    var checkField = CheckField.shared
    var service = Service.shared
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailVIew: UIView!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var repPassField: UITextField!
    @IBOutlet weak var repPasswordView: UIView!
    
    var delegate: LoginViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func openAuthVC(_ sender: Any) {
        delegate.closeVC()
        delegate.openAuthVC()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func regBtnClick(_ sender: Any) {
        if checkField.validField(emailVIew, emailField),
           checkField.validField(passwordView, passField)
        {
            if passField.text == repPassField.text
            {
                service.createNewUser(LoginField(email: emailField.text!, password: passField.text!)) {
                    [weak self] code in
                    switch code.code {
                    case 0:
                        print("Ошибка регистрации")
                    case 1:
                        self?.service.confirmEmail()
                        let alert = UIAlertController(title: "OK", message: "Success", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "Ok", style: .default) { _ in
                            self?.delegate.closeVC()
                            self?.delegate.openAuthVC()
                        }
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true)
                    default:
                        print("no")
                    }
                }
            } else {
                print("not ok")
            }
        }
    }
    
    
}
