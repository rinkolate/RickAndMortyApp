//
//  ImageLoader.swift
//  RickAndMortyApp
//
//  Created by Toshpulatova Lola on 08.09.2025.
//

import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

final class ImageLoader {
    static let shared = ImageLoader()
    private var currentTasks: [String: URLSessionDataTask] = [:]

    private init() {}

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> String? {
        let cacheKey = urlString as NSString
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            completion(cachedImage)
            return nil
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            ImageCache.shared.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async {
                completion(image)
            }

            self.currentTasks.removeValue(forKey: urlString)
        }

        currentTasks[urlString] = task
        task.resume()

        return urlString
    }

    func cancelLoad(_ taskId: String?) {
        guard let taskId = taskId else { return }
        currentTasks[taskId]?.cancel()
        currentTasks.removeValue(forKey: taskId)
    }
}
