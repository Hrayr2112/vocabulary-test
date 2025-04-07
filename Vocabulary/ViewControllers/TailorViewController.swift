import UIKit
import SnapKit

enum TailorNextPage {
    case selectGender
    case vocabularyLevel
    case selectGoals
    
    var viewController: UIViewController {
        switch self {
        case .selectGender:
            return SelectGenderViewController()
        case .vocabularyLevel:
            return SelectVocabularyLevelViewController()
        case .selectGoals:
            return SelectGoalsViewController()
        }
    }
}

final class TailorViewController: UIViewController {
    var nextPage: TailorNextPage = .selectGender
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tailor your word \n recommendations"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupStyle()
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "tailorPageBG"))
        backgroundImage.clipsToBounds = true
        return backgroundImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(continueButton)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundImage.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(20)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueButtonTapped() {
        Haptic.make()
        navigationController?.pushViewController(nextPage.viewController, animated: true)
    }
}

