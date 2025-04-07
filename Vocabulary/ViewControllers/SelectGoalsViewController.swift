import UIKit
import SnapKit

final class SelectGoalsViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you have a specific goal\nin mind?"
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
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
        return tableView
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupStyle()
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    private let goals = ["Improve my job prospects", "Get ready for a test", "Enhance my lexicon", "Enjoy learning new words", "Other"]
    private var selectedGoals: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(continueButton)
        
        tableView.dataSource = self
        tableView.delegate = self
       
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(continueButton.snp.top).offset(-20)
        }

        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.height.equalTo(49)
        }
    }

    @objc private func continueButtonTapped() {
        Haptic.make()
        let vc = SelectTopicsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SelectGoalsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell else {
            fatalError("Could not dequeue TopicCell")
        }
        let topic = goals[indexPath.row]
        let isSelected = selectedGoals.contains(topic)
        cell.configure(with: topic, isSelected: isSelected)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTopic = goals[indexPath.row]
        if let index = selectedGoals.firstIndex(of: selectedTopic) {
            selectedGoals.remove(at: index)
        } else {
            selectedGoals.append(selectedTopic)
        }
        Haptic.make()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
