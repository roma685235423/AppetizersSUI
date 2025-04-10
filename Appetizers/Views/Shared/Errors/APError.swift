import Foundation
import SwiftUI

/// Перечисление возможных ошибок при сетевых операциях.
///
/// `APError` используется для представления ошибок, которые могут возникнуть при
/// выполнении сетевых запросов, например при загрузке данных с сервера.
///
/// Каждое значение перечисления представляет конкретный тип ошибки:
/// - `invalidURL`: Некорректный URL-адрес.
/// - `invalidResponse`: Некорректный HTTP-ответ от сервера.
/// - `invalidData`: Невозможно декодировать полученные данные.
/// - `unableToComplete`: Ошибка соединения или завершения запроса.
///
/// Также предоставляет метод для преобразования ошибки в `AlertItem`,
/// чтобы отобразить её пользователю в виде алерта.
enum APError: Error {

    /// URL-адрес недействителен.
    case invalidURL

    /// Ответ от сервера некорректен.
    case invalidResponse

    /// Данные с сервера невозможно обработать.
    case invalidData

    /// Запрос не может быть завершён (например, проблемы с сетью).
    case unableToComplete

    /// Преобразует ошибку в `AlertItem` для отображения в UI.
    ///
    /// - Returns: Объект `AlertItem` с заголовком и сообщением об ошибке.
    func alertItem() -> AlertItem {
        switch self {
        case .invalidData:
            AlertItem(
                title: Text("Server Error"),
                message: Text("The data returned from the server was invalid. Please contact support.")
            )
        case .invalidResponse:
            AlertItem(
                title: Text("Server Error"),
                message: Text("Invalid response from the server. Please try again later or contact support.")
            )
        case .invalidURL:
            AlertItem(
                title: Text("Server Error"),
                message: Text("There is an issue connecting to the server. Please try again later or contact support.")
            )
        case .unableToComplete:
            AlertItem(
                title: Text("Server Error"),
                message: Text("Unable to complete your request at this time. Please check your internet connection.")
            )
        }
    }
}
