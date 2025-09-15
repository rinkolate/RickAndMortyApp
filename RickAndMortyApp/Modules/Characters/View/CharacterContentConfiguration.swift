import UIKit

struct CharacterContentConfiguration: UIContentConfiguration {
    let model: CharacterModel

    func makeContentView() -> UIView & UIContentView {
        CharacterContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> CharacterContentConfiguration {
        self
    }
}

final class CharacterContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            guard let newConfiguration = configuration as? CharacterContentConfiguration else { return }
            update(with: newConfiguration.model)
        }
    }

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .rickCellBackground
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .rickWhite
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    init(configuration: CharacterContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupView()
        addSubviews()
        addConstraints()
        update(with: configuration.model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .clear
    }

    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(titleLabel)
    }

    private func addConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),

            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            characterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }

    func update(with model: CharacterModel) {
        titleLabel.text = model.name
        characterImageView.setImage(from: model.image)
    }
}
