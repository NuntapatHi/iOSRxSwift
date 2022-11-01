//
//  ViewController.swift
//  iOSRxSwift
//
//  Created by Nuntapat Hirunnattee on 1/11/2565 BE.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var alertLoginLabel: UILabel!
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    var usernameString: String {
        get{
            return usernameTextField.text ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.usernameTextPubilshSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordTextPubilshSubject).disposed(by: disposeBag)
        
        viewModel.isValid().bind(to: alertLoginLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.isValid().map { $0 ? 1: 0.7}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }


    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Login", message: "\(usernameString) has suscessfully login to the app.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
