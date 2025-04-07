import UIKit
import SnapKit

final class WordCarouselViewController: UIViewController {
    
    private let words: [Word] = [
        Word(word: "Ethereal", pronunciation: "/iˈTHirēəl/", definition: "Extremely delicate and light in a way that seems not of this world.", example: "The morning mist gave the forest an ethereal glow."),
        Word(word: "Serendipity", pronunciation: "/ˌserənˈdipədē/", definition: "The occurrence of events by chance in a happy or beneficial way.", example: "Meeting her was pure serendipity."),
        Word(word: "Ephemeral", pronunciation: "/əˈfem(ə)rəl/", definition: "Lasting for a very short time.", example: "Fame in the age of social media is often ephemeral."),
        Word(word: "Quintessential", pronunciation: "/ˌkwin(t)əˈsen(t)SHəl/", definition: "Representing the most perfect or typical example of a quality or class.", example: "He is the quintessential gentleman."),
        Word(word: "Solitude", pronunciation: "/ˈsäləˌt(y)o͞od/", definition: "The state or situation of being alone.", example: "She savored the peace and solitude of the beach.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground

        let carousel = InfiniteVerticalWordCarousel(words: words)
        view.addSubview(carousel)
        carousel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
