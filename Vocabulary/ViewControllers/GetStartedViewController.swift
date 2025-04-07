import UIKit
import SnapKit

final class GetStartedViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Expand your Vocabulary in\n1 minute a day"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Learn 10,000+ new words with a new daily habit\nthat takes just 1 minute"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.text = "350 million     4.8 ★★★★★     10 million"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupStyle()
        button.setTitle("Get started", for: .normal)
        return button
    }()
    
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "startPageBG"))
        backgroundImage.clipsToBounds = true
        return backgroundImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .background
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(statsLabel)
        view.addSubview(getStartedButton)
        
        backgroundImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundImage.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
        }
        
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        statsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(getStartedButton.snp.top).inset(-30)
            make.centerX.equalToSuperview()
        }
        
        getStartedButton.addTarget(self, action: #selector(onGetStartedTapped), for: .touchUpInside)
    }
    
    @objc private func onGetStartedTapped() {
        Haptic.make()
        let howDidYouHearVC = HowDidYouHearViewController()
        navigationController?.pushViewController(howDidYouHearVC, animated: true)
    }
}
 
