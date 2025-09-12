import UIKit

// EpisodesContentConfiguration: Это структура, которая реализует протокол UIContentConfiguration. Она используется для описания конфигурации содержимого, которое будет отображаться в ячейке.
struct EpisodesContentConfiguration: UIContentConfiguration {

    // model: Это свойство типа EpisodesViewModel, которое содержит данные, необходимые для настройки отображения.
    let model: EpisodesModel

    // makeContentView(): Этот метод создает и возвращает объект EpisodesContentView, используя текущую конфигурацию. Он возвращает объект, который является одновременно UIView и UIContentView.
    func makeContentView() -> any UIView & UIContentView {
        EpisodesContentView(configuration: self)
    }
    // updated(for:): Этот метод возвращает обновленную конфигурацию для заданного состояния. В данном случае он просто возвращает текущую конфигурацию без изменений.
    func updated(for state: any UIConfigurationState) -> EpisodesContentConfiguration {
        self
    }

}

final class EpisodesContentView: UIView, UIContentView {

    // contentConfiguration: Приватное свойство, которое хранит текущую конфигурацию содержимого.
    private var contentConfiguration: EpisodesContentConfiguration
    // configuration: Это свойство, которое реализует протокол UIContentView. Оно позволяет получить или установить конфигурацию. При установке новой конфигурации вызывается метод update(with:) для обновления отображения.
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
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension EpisodesContentView {

    func update(with model: EpisodesModel) {
        titleLabel.text = model.name
        episodeLabel.text = model.episodeNumber + ", " + model.episodeSeason
        dateLabel.text = model.releaseDate
    }

    func addSubviews() {
        addSubview(titleLabel)
        addSubview(episodeLabel)
        addSubview(dateLabel)
    }

    func addConstraints() {
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
