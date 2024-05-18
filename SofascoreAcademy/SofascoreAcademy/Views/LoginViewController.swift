import Foundation
import UIKit
import SnapKit
import SofaAcademic

class LoginViewController: UIViewController {
    
    private let iconImageLabel = UIImageView.init(image: UIImage(named: "sofascore_logo"))
    private var shouldSpin: Bool = true
    private let loginForm = UIView()
    private var bottomConstraint: Constraint?
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    let customIndicator = UIImageView.init(image: UIImage(named: "AppIcon"))
    
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)

        button.titleLabel?.font = Fonts.RobotoRegular14
        button.setTitleColor(Colors.colorPrimaryDefault, for: .normal)
        button.setTitleColor(Colors.colorPrimaryVariant, for: .highlighted)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        subscribeToKeyboardNotifications()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setupView() {
        view.backgroundColor = Colors.colorPrimaryDefault
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    @objc func loginButtonTapped() {
        view.endEditing(true)
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if validateEmail(email) && validatePassword(password) {
            
            animateLogin()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.shouldSpin = false;
                self.activityIndicator.stopAnimating()
                let mainViewController = MainViewController()
                self.navigationController?.pushViewController(mainViewController, animated: true)
            }
        } else {
            showErrorAlert()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func showSuccessAlert() {
        let alertController = UIAlertController(title: "Success", message: "Login successful!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Invalid email or password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(customIndicator)
        
        view.addSubview(iconImageLabel)
        view.addSubview(loginForm)
        view.addSubview(activityIndicator)
        loginForm.addSubview(emailTextField)
        loginForm.addSubview(passwordTextField)
        loginForm.addSubview(loginButton)
    }
    
    func styleViews() {
        customIndicator.contentMode = .scaleAspectFit
        customIndicator.isHidden = true
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 5
        activityIndicator.color = .white
    }
    
    func setupConstraints() {
        iconImageLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(132+66)
        }
        
        customIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(50)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        loginForm.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
            bottomConstraint = $0.bottom.equalToSuperview().inset(100).constraint
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.height.equalTo(40)
        }
    }
    
    func setupGestureRecognizers() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.height
        
        bottomConstraint?.update(offset: -keyboardHeight - 20)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint?.update(inset: 100)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func animateLogin() {
        
        
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseInOut, animations: {
            self.loginForm.alpha = 0
        }) { _ in
            self.loginForm.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.transition(with: self.customIndicator, duration: 0.7, options: .transitionCrossDissolve, animations: {
                self.customIndicator.isHidden = false
            }, completion: nil)
            self.spinImage()
        }
    }
    
    
    
    func spinImage() {
        UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseInOut, animations: {
            self.customIndicator.transform = self.customIndicator.transform.rotated(by: CGFloat.pi)
        }) { _ in
            if(self.shouldSpin) {
                self.spinImage()
            }
        }
    }
}

extension UIView {
    func changeBackgroundColorWithFade(to color: UIColor) {
        UIView.animate(withDuration: 1.5) {
            self.backgroundColor = color
        }
    }
}
