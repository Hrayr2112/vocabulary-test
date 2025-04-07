import UIKit
import SnapKit

final class TopicCell: UITableViewCell {

    private let container: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 26
        return view
    }()
    
    private let topicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        imageView.tintColor = UIColor(red: 101/255, green: 197/255, blue: 184/255, alpha: 1.0)
        imageView.isHidden = true
        return imageView
    }()
    
    private let unselectedCircle: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 12
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        container.addSubview(checkmarkImageView)
        container.addSubview(unselectedCircle)
        container.addSubview(topicLabel)
        contentView.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
            make.height.equalTo(52)
        }

        topicLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }

        checkmarkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        unselectedCircle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }

    func configure(with topic: String, isSelected: Bool) {
        topicLabel.text = topic
        checkmarkImageView.isHidden = !isSelected
        unselectedCircle.isHidden = isSelected
        container.layer.borderColor = UIColor(white: 1, alpha: isSelected ? 1 : 0.2).cgColor
        container.layer.borderWidth = isSelected ? 2 : 1
    }
}
