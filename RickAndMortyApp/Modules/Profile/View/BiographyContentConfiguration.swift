import UIKit
import NetworkingManager



struct BiographyContentConfiguration: UIContentConfiguration {
    let model: BiographyModel

    func makeContentView() -> UIView & UIContentView {
        BiographyContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> BiographyContentConfiguration {
        self
    }
}

final class BiographyContentView: UIView, UIContentView {
    private var contentConfiguration: BiographyContentConfiguration
    var configuration: UIContentConfiguration {
        get { contentConfiguration }
        set {
            guard let newConfiguration = newValue as? BiographyContentConfiguration else { return }
            contentConfiguration = newConfiguration
            update(with: contentConfiguration.model)
        }
    }

    // Avatar, name and status (no background)
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .rickWhite
        label.textAlignment = .center
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickGreen
        label.textAlignment = .center
        return label
    }()

    // Info section
    private let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.font = .gilroySemiBold(size: 17)
        label.textColor = .rickWhite
        return label
    }()

    private let infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .rickCellBackground
        view.layer.cornerRadius = 12
        return view
    }()

    private let speciesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickLightGray
        return label
    }()

    private let speciesValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickWhite
        label.textAlignment = .right
        return label
    }()

    private let typeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Type:"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickLightGray
        return label
    }()

    private let typeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickWhite
        label.textAlignment = .right
        return label
    }()

    private let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickLightGray
        return label
    }()

    private let genderValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .rickWhite
        label.textAlignment = .right
        return label
    }()

    // Origin section
    private let originTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Origin"
		label.font = .gilroySemiBold(size: 17)
		label.textColor = .rickWhite
		return label
    }()

    private let originContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .rickCellBackground
        view.layer.cornerRadius = 12
        return view
    }()

    private let planetContainer: UIView = {
            let view = UIView()
            view.backgroundColor = .rickDarkBlue
            view.layer.cornerRadius = 10
            return view
        }()

    private let planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "planet_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let originNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .rickWhite
        return label
    }()

    private let originTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .rickLightGray
        return label
    }()

    init(configuration: BiographyContentConfiguration) {
        self.contentConfiguration = configuration
        super.init(frame: .zero)
        backgroundColor = .clear // Прозрачный фон
        setupViews()
        addSubviews()
        addConstraints()
        update(with: contentConfiguration.model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Никакой дополнительной настройки не нужно, все элементы прозрачные
    }

    private func addSubviews() {
        // Avatar, name and status (no container)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(statusLabel)

        // Info section
        addSubview(infoTitleLabel)
        addSubview(infoContainer)
        infoContainer.addSubview(speciesTitleLabel)
        infoContainer.addSubview(speciesValueLabel)
        infoContainer.addSubview(typeTitleLabel)
        infoContainer.addSubview(typeValueLabel)
        infoContainer.addSubview(genderTitleLabel)
        infoContainer.addSubview(genderValueLabel)

        // Origin section
        addSubview(originTitleLabel)
        addSubview(originContainer)
        originContainer.addSubview(planetContainer)
        originContainer.addSubview(planetImageView)
        originContainer.addSubview(originNameLabel)
        originContainer.addSubview(originTypeLabel)
    }

    private func addConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        planetContainer.translatesAutoresizingMaskIntoConstraints = false

        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        speciesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        typeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        typeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        genderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        genderValueLabel.translatesAutoresizingMaskIntoConstraints = false

        originTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        originContainer.translatesAutoresizingMaskIntoConstraints = false
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        originNameLabel.translatesAutoresizingMaskIntoConstraints = false
        originTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
[
            // Avatar, name and status
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 148),
            avatarImageView.heightAnchor.constraint(equalToConstant: 148),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Info section
            infoTitleLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 24),
            infoTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            infoContainer.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 12),
			infoContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
			infoContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
			infoContainer.heightAnchor.constraint(equalToConstant: 124),

            speciesTitleLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 16),
            speciesTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            speciesValueLabel.centerYAnchor.constraint(equalTo: speciesTitleLabel.centerYAnchor),
            speciesValueLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),

            typeTitleLabel.topAnchor.constraint(equalTo: speciesTitleLabel.bottomAnchor, constant: 12),
            typeTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            typeValueLabel.centerYAnchor.constraint(equalTo: typeTitleLabel.centerYAnchor),
            typeValueLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),

            genderTitleLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor, constant: 12),
            genderTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            genderValueLabel.centerYAnchor.constraint(equalTo: genderTitleLabel.centerYAnchor),
            genderValueLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),

            // Origin section
            originTitleLabel.topAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: 24),
            originTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            originContainer.topAnchor.constraint(equalTo: originTitleLabel.bottomAnchor, constant: 12),
			originContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
			originContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
			originContainer.heightAnchor.constraint(equalToConstant: 80),
			originContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),

            planetContainer.leadingAnchor.constraint(equalTo: originContainer.leadingAnchor,constant: 8),
            planetContainer.centerYAnchor.constraint(equalTo: originContainer.centerYAnchor),
            planetContainer.widthAnchor.constraint(equalToConstant: 64),
            planetContainer.heightAnchor.constraint(equalToConstant: 64),

            planetImageView.centerYAnchor.constraint(equalTo: planetContainer.centerYAnchor),
            planetImageView.leadingAnchor.constraint(equalTo: planetContainer.leadingAnchor, constant: 20),
            planetImageView.widthAnchor.constraint(equalToConstant: 24),
            planetImageView.heightAnchor.constraint(equalToConstant: 24),

            originNameLabel.topAnchor.constraint(equalTo: originContainer.topAnchor, constant: 16),
            originNameLabel.leadingAnchor.constraint(equalTo: planetContainer.trailingAnchor, constant: 16),

            originTypeLabel.topAnchor.constraint(equalTo: originNameLabel.bottomAnchor, constant: 4),
            originTypeLabel.leadingAnchor.constraint(equalTo: planetContainer.trailingAnchor, constant: 16),
        ]
)
    }

    private func update(with model: BiographyModel) {
        // Avatar, name and status
        avatarImageView.setImage(from: model.photo)
        nameLabel.text = model.name
        statusLabel.text = model.status
        statusLabel.textColor = model.status == "Alive" ? .rickGreen : .rickLightGray

        // Info section
        speciesValueLabel.text = model.species
        typeValueLabel.text = model.type.isEmpty ? "None" : model.type
        genderValueLabel.text = model.gender

        // Origin section
        originNameLabel.text = model.origin
        originTypeLabel.text = "Planet"
        originTypeLabel.textColor = .rickGreen
    }
}
