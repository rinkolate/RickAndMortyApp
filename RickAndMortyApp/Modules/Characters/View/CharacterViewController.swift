//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Toshpulatova Lola on 07.09.2025.
//
import UIKit

final class CharacterViewController: UIViewController {

    lazy var contentView: DisplaysCharacter = CharacterView()
    private var characters: [CharacterModel] = []
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView as? UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1.0)
        setupActivityIndicator()
        fetchCharacters()

        
        setupCollectionViewSelectionHandler()
    }

    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    private func fetchCharacters() {
        activityIndicator.startAnimating()

        NetworkService.shared.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()

                switch result {
                case .success(let characters):
                    self?.characters = characters.map { CharacterModel(from: $0) }
                    self?.contentView.setupCharacters(self?.characters ?? [])
                case .failure(let error):
                    print("Error fetching characters: \(error.localizedDescription)")
                    self?.showMockData()
                }
            }
        }
    }

    private func showMockData() {
        characters = [
            CharacterModel(
                id: 1,
                name: "Rick Sanchez",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episodeUrls: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"
                ]
            ),
        ]
        contentView.setupCharacters(characters)
    }

    private func setupCollectionViewSelectionHandler() {
        // Получаем доступ к коллекции через contentView
        if let characterView = contentView as? CharacterView {
            characterView.collectionView.delegate = self
        }
    }
}

// Добавляем соответствие протоколу в extension
extension CharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.item]
        print("Selected character: \(selectedCharacter.name)")


        // Создаем и переходим к экрану профиля
        let provider = ProfileProvider()
        let profileViewController = ProfileViewController()
        let presenter = ProfilePresenter(viewController: profileViewController, provider: provider)
        profileViewController.presenter = presenter

        // Передаем выбранного персонажа
        profileViewController.selectedCharacter = selectedCharacter

        // Устанавливаем заголовок с именем персонажа
        profileViewController.title = selectedCharacter.name

        // Переходим к экрану профиля
        navigationController?.pushViewController(profileViewController, animated: true)

        // Снимаем выделение с ячейки
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CharacterViewController: DisplaysCharacter {
    func setupCharacters(_ model: [CharacterModel]) {
        // Реализация протокола
    }
}
