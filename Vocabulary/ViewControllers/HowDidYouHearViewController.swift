import UIKit
import SnapKit

final class HowDidYouHearViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How did you hear\nabout Vocabulary?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OptionCell.self, forCellReuseIdentifier: "OptionCell")
        return tableView
    }()
    
    private let options = [
        "Facebook", "Instagram", "TikTok", "App Store",
        "Web search", "Friend/family", "Other"
    ]
    
    private var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}

extension HowDidYouHearViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as? OptionCell else {
            return UITableViewCell()
        }
        cell.configure(with: options[indexPath.row], isSelected: indexPath.row == selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        Haptic.make()
        tableView.reloadRows(at: [IndexPath(row: selectedIndex!, section: 0)], with: .fade)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let vc = TailorViewController()
            vc.nextPage = .selectGender
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

