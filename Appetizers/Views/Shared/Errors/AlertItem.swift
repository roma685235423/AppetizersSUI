import SwiftUI

/// Модель данных для отображения алерта в SwiftUI.
///
/// `AlertItem` используется как обёртка для отображения алертов с помощью `.alert(item:)` в SwiftUI.
/// Каждому алерту присваивается уникальный идентификатор, чтобы SwiftUI могла корректно отслеживать отображаемые сообщения.
///
/// - Properties:
///   - id: Уникальный идентификатор алерта.
///   - title: Заголовок алерта (`Text`).
///   - message: Основное сообщение алерта (`Text`).
///
/// - Example:
/// ```swift
/// @State private var alertItem: AlertItem?
///
/// .alert(item: $alertItem) { item in
///     Alert(title: item.title, message: item.message, dismissButton: .default(Text("OK")))
/// }
/// ```
struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
}
