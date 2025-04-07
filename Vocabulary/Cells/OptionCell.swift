import UIKit
import SnapKit

final class OptionCell: UITableViewCell {
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    private let radioCircle: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let selectedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 26
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String, isSelected: Bool) {
        optionLabel.text = text
        selectedView.isHidden = !isSelected
        container.layer.borderColor = UIColor(white: 1, alpha: isSelected ? 1 : 0.2).cgColor
        container.layer.borderWidth = isSelected ? 2 : 1
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(container)
        container.addSubview(optionLabel)
        container.addSubview(radioCircle)
        radioCircle.addSubview(selectedView)

        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
            make.height.equalTo(52)
        }

        optionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        radioCircle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(24)
        }
        
        selectedView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
    }
}

