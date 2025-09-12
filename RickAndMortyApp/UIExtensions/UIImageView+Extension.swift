//
//  UIImageView+Extension.swift
//  RickAndMortyApp
//
//  Created by Toshpulatova Lola on 10.09.2025.
//
import NetworkingManager
import UIKit

public extension UIImageView {

    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            assertionFailure("Invalid URL: \(urlString)")
            return
        }
        let service: DataServiceProtocol = DataService()
        Task {
            do {
                let loadedData = try await service.getData(from: url)
                self.image = UIImage(data: loadedData)
            } catch {
                assertionFailure("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
    
}



