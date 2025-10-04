import UIKit

final class ProfileSectionHeaderView: UICollectionReusableView {
    private let label: UILabel = {
        let label = UILabel()
        label.font = .gilroySemiBold(size: 17)
        label.textColor = .rickWhite
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupConstraints()
//        label.backgroundColor = .red
//        backgroundColor = .green
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String?) {
        self.label.text = text
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
