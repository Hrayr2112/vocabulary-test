import UIKit
import SnapKit

final class InputNameViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to\nbe called?"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your name"
        textField.textColor = .white
        textField.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 48))
        textField.leftView = paddingView
        textField.rightView = paddingView
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Your name", attributes: attributes)
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupStyle()
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObserver()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(skipButton)
        view.addSubview(nameTextField)
        view.addSubview(continueButton)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil) {
                [weak self] notification in
                self?.keyboardWillShow(notification)
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil) {
                [weak self] notification in
                self?.keyboardWillHide(notification)
        }
    }
    
    @objc private func continueButtonTapped() {
        Haptic.make()
        let vc = TailorViewController()
        vc.nextPage = .vocabularyLevel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func hideKeyboard() {
        nameTextField.resignFirstResponder()
    }
    
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - view.safeAreaInsets.bottom
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat ?? 0.1
           
            continueButton.snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(keyboardHeight + 10)
            }
            
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    private func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat ?? 0.1
        
        continueButton.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
}
