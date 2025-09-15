import UIKit

struct EpisodesContentConfiguration: UIContentConfiguration {
    let model: EpisodesModel

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

    init(configuration: EpisodesContentConfiguration) {
        self.contentConfiguration = configuration
        super.init(frame: .zero)
        backgroundColor = .rickCellBackground
        layer.cornerRadius = 16
        addSubviews()
        addConstraints()
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
    }

    private func addConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),

            episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            episodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            episodeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            episodeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
