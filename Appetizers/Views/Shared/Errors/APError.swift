import Foundation
import SwiftUI

/// Перечисление возможных ошибок при сетевых операциях.
///
/// `APError` используется для представления ошибок, которые могут возникнуть при
/// выполнении сетевых запросов, а также при обработке формы профиля пользователя.
///
/// Каждое значение перечисления представляет конкретный тип ошибки или состояния:
/// - `invalidURL`: Некорректный URL-адрес.
/// - `invalidResponse`: Некорректный HTTP-ответ от сервера.
/// - `invalidData`: Невозможно декодировать полученные данные.
/// - `unableToComplete`: Ошибка соединения или завершения запроса.
/// - `invalidForm`: Некорректно заполненная форма (например, отсутствуют обязательные поля).
/// - `invalidEmail`: Невалидный email.
/// - `userSaveSuccess`: Успешное сохранение данных пользователя.
/// - `invalidUserData`: Ошибка при сохранении данных пользователя.
///
/// Используется в связке с `AlertItem`, чтобы отображать понятные пользователю алерты.
///
/// - Метод:
///   - `alertItem()`: Преобразует ошибку в `AlertItem` для отображения в UI.
///
/// - Пример использования:
/// ```swift
/// viewModel.alertItem = APError.invalidResponse.alertItem()
/// ```
enum APError: Error {

    /// URL-адрес недействителен.
    case invalidURL

    /// Ответ от сервера некорректен.
    case invalidResponse

    /// Данные с сервера невозможно обработать.
    case invalidData

    /// Запрос не может быть завершён (например, проблемы с сетью).
    case unableToComplete

    /// Некорректно заполненная форма.
    case invalidForm

    /// Неверно введён адрес электронной почты.
    case invalidEmail

    /// Успешное сохранение данных пользователя.
    case userSaveSuccess

    /// Ошибка при сохранении данных пользователя.
    case invalidUserData

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
        case .invalidForm:
            AlertItem(
                title: Text("Invalid Form"),
                message: Text("Please ensure all fields in the form are complete and correct.")
            )
        case .invalidEmail:
            AlertItem(
                title: Text("Invalid Email"),
                message: Text("Please ensure you have entered a valid email address.")
            )
        case .userSaveSuccess:
            AlertItem(
                title: Text("Profile Saved"),
                message: Text("Your profile information has been saved successfully.")
            )
        case .invalidUserData:
            AlertItem(
                title: Text("Profile Error"),
                message: Text("There was an issue saving your profile information. Please try again.")
            )
        }
    }
}
