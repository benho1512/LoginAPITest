//
//  ViewController.swift
//  LoginAPITest
//
//  Created by Nguyen Duy anh on 2/25/20.
//  Copyright © 2020 Nguyen Duy anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        editElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.alpha = 0
    }
    
    func editElement() {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        errorLabel.alpha = 0
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        
        
        UserManager.shared.fetchUsers { (response) in
            switch response {
            case .failure(let err):
                print("Failed to fetch error", err)
            case .success(let users):
                if email == "" || password == "" {
                    self.showError("Please enter your email and password")
                } else if !email.isEmail {
                    self.showError("Please make sure your email is in the correct format")
                } else if !password.isValidPassword {
                    self.showError("Please make sure your password is at least 8 characters, contains a special character and a number")
                } else {
                    if users.count == 0 {
                        self.showError("Failed found to user")
                    } else {
                        for user in users {
                            if email == user.email && password == user.password {
                                self.transitionFromHome()
                                //return
                                break
                            } else {
                                self.showError("Email or password is not valid")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorLabel.alpha = 1
            self.errorLabel.text = message
            
        }
    }
       
    func transitionFromHome() {
        DispatchQueue.main.async {
            let navVC = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let homeVC = navVC.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
            //homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true, completion: nil)
            
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
}
