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
    private let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    
    let customIndicator = UIImageView.init(image: UIImage(named: "sofaLogoTransparent"))
    
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.onSurfaceOnSurfaceLv2])
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.textContentType = .oneTimeCode
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.backgroundColor = .white
        textField.textColor = .black
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.onSurfaceOnSurfaceLv2])
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.backgroundColor = .white
        textField.textColor = .black
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .action
        button.setTitleColor(.white, for: .normal)
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
        
        checkIfKeychainExists()
        setupView()
        subscribeToKeyboardNotifications()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        resetViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.shouldSpin = false;
        unsubscribeFromKeyboardNotifications()
    }
    
    func setupView() {
        view.backgroundColor = .colorPrimaryDefault
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
                self.activityIndicator.stopAnimating()
                Keychain.saveTokenToKeychain(token: "academy_token")
                
                let mainViewController = MainViewController()
                self.navigationController?.pushViewController(mainViewController, animated: true)
                // how to reset this viewcontroller, becasue when i log ou i want ot return back here
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
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func styleViews() {
        customIndicator.contentMode = .scaleAspectFit
        customIndicator.isHidden = true
        loginButton.backgroundColor = .colorPrimaryDefault
        
        loginButton.layer.cornerRadius = 10
        
        activityIndicator.color = .white
        
        backgroundImageView.image = UIImage(named: "loginBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 13
        passwordTextField.layer.masksToBounds = true
        
        loginForm.backgroundColor = UIColor(white: 0, alpha: 0.7)
        loginForm.layer.cornerRadius = 15
        loginForm.layer.masksToBounds = true
        
        
    }
    
    func setupConstraints() {
        iconImageLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(198)
        }
        
        customIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(50)
            $0.height.width.equalTo(50)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        loginForm.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(240)
            bottomConstraint = $0.bottom.equalToSuperview().inset(100).constraint
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(80)
            $0.height.equalTo(40)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
    
    func checkIfKeychainExists() {
        if(Keychain.isTokenExistingInKeychain(token: "academy_token")) {
            let mainViewController = MainViewController()
            self.navigationController?.pushViewController(mainViewController, animated: true)
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

extension LoginViewController {
    func resetViewController() {
        emailTextField.text = ""
        passwordTextField.text = ""
        customIndicator.isHidden = true
        shouldSpin = true
        loginForm.isHidden = false
        loginForm.alpha = 1.0
        subscribeToKeyboardNotifications()
    }
}

