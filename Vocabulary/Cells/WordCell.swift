import UIKit
import SnapKit

final class WordCell: UICollectionViewCell {
    static let identifier = "WordCell"

    private let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let pronunciationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(word: Word) {
        wordLabel.text = word.word
        pronunciationLabel.text = word.pronunciation
        definitionLabel.text = word.definition
        exampleLabel.text = word.example
    }

    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(wordLabel)
        contentView.addSubview(pronunciationLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(exampleLabel)
        
        wordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(400)
            make.left.right.equalToSuperview().inset(20)
        }

        pronunciationLabel.snp.makeConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }

        definitionLabel.snp.makeConstraints { make in
            make.top.equalTo(pronunciationLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(20)
        }

        exampleLabel.snp.makeConstraints { make in
            make.top.equalTo(definitionLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}

struct Word {
    let word: String
    let pronunciation: String
    let definition: String
    let example: String
}
