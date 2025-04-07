import UIKit
import SnapKit

class InfiniteVerticalWordCarousel: UIView {

    private var collectionView: UICollectionView!
    private var originalWords: [Word] = []

    private var loopedWords: [Word] {
        guard originalWords.count > 1 else { return originalWords }
        return [originalWords.last!] + originalWords + [originalWords.first!]
    }

    init(words: [Word]) {
        self.originalWords = words
        super.init(frame: .zero)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)

            section.visibleItemsInvalidationHandler = { [weak self] _, offset, _ in
                guard let self = self else { return }
                let index = Int(round(offset.y / self.collectionView.bounds.height))
                let maxIndex = self.loopedWords.count - 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    if index == 0 {
                        self.collectionView.scrollToItem(at: IndexPath(item: maxIndex - 1, section: 0), at: .top, animated: false)
                    } else if index == maxIndex {
                        self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .top, animated: false)
                    }
                }
            }

            return section
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WordCell.self, forCellWithReuseIdentifier: WordCell.identifier)

        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension InfiniteVerticalWordCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        loopedWords.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCell.identifier, for: indexPath) as? WordCell else {
            return UICollectionViewCell()
        }

        let word = loopedWords[indexPath.item]
        cell.configure(word: word)
        return cell
    }
}

extension InfiniteVerticalWordCarousel: UICollectionViewDelegate {}
