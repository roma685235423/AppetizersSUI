import Foundation
import UIKit

/// Менеджер сетевых операций приложения.
///
/// `NetworkManager` предоставляет API для загрузки данных и изображений из удалённого сервера.
/// Реализован как синглтон (`NetworkManager.shared`) и используется в UI и ViewModel слоях.
///
/// Основные функции:
/// - Загрузка списка закусок (`AppetizerDTO`)
/// - Асинхронная загрузка изображений с кэшированием (`NSCache`)
///
/// - Пример использования:
/// ```swift
/// NetworkManager.shared.getAppetizers { result in ... }
/// NetworkManager.shared.downloadImage(from: url) { image in ... }
/// ```
final class NetworkManager {

    /// Общий экземпляр `NetworkManager` (синглтон).
    static let shared = NetworkManager()

    /// Кэш для загруженных изображений.
    /// Используется для предотвращения повторной загрузки одних и тех же изображений.
    private var cache = NSCache<NSString, UIImage>()

    /// Базовый URL-адрес сервера.
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"

    /// Полный путь к endpoint'у для получения списка закусок.
    private let appetizerURL = baseURL + "appetizers"

    /// Приватный инициализатор для предотвращения создания экземпляров извне.
    private init() {}

    /// Загружает список закусок с сервера.
    ///
    /// Отправляет GET-запрос по `appetizerURL`, декодирует ответ в `AppetizerResponse`,
    /// и передаёт результат в виде массива `AppetizerDTO` через `Result`.
    ///
    /// - Parameter completion: Замыкание, вызываемое по завершении запроса.
    ///   - `success`: Список объектов `AppetizerDTO`.
    ///   - `failure`: Ошибка типа `APError`.
    func getAppetizers(completion: @escaping (Result<[AppetizerDTO], APError>) -> Void) {
        guard let url = URL(string: appetizerURL) else {
            return completion(.failure(.invalidURL))
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completion(.success(decodedResponse.request))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    /// Загружает изображение по URL и кэширует результат.
    ///
    /// Если изображение уже находится в кэше, оно немедленно возвращается из него.
    /// В противном случае изображение загружается по сети, добавляется в кэш и передаётся в `completion`.
    ///
    /// - Parameters:
    ///   - urlString: Строка с URL изображения.
    ///   - completion: Замыкание с результатом: `UIImage?`.
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = urlString as NSString

        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
