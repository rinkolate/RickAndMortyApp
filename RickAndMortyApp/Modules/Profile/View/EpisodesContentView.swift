import UIKit

struct EpisodesContentConfiguration: UIContentConfiguration {
    let model: EpisodesModel
    var onButtonTap: (() -> Void)? 

    func makeContentView() -> UIView & UIContentView {
        EpisodesContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> EpisodesContentConfiguration {
        self
    }
}

final class EpisodesContentView: UIView, UIContentView {
    private var contentConfiguration: EpisodesContentConfiguration
    var configuration: UIContentConfiguration {
        get { contentConfiguration }
        set {
            guard let newConfiguration = newValue as? EpisodesContentConfiguration else { return }
            contentConfiguration = newConfiguration
            update(with: contentConfiguration.model)
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .rickWhite
        return label
    }()

    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .rickGreen
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .rickLightGray
        return label
    }()

    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        let arrowImage = UIImage(systemName: "arrow.up.forward.app")?
            .withConfiguration(UIImage.SymbolConfiguration(scale: .small));        button.setImage(arrowImage, for: .normal)
        button.tintColor = .rickWhite
        button.backgroundColor = .rickCellBackground
        return button
    }()

    init(configuration: EpisodesContentConfiguration) {
        self.contentConfiguration = configuration
        super.init(frame: .zero)
        backgroundColor = .rickCellBackground
        layer.cornerRadius = 16
        addSubviews()
        addConstraints()
        setupButtonAction()
        update(with: contentConfiguration.model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update(with model: EpisodesModel) {
        titleLabel.text = model.name
        episodeLabel.text = model.episodeNumber + ", " + model.episodeSeason
        dateLabel.text = model.releaseDate
    }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(episodeLabel)
        addSubview(dateLabel)
        addSubview(actionButton)
    }

    private func addConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            actionButton.widthAnchor.constraint(equalToConstant: 20),
            actionButton.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -8),

            episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            episodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            episodeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupButtonAction() {
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        contentConfiguration.onButtonTap?()
    }
}
