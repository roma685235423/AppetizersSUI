import SwiftUI

/// Модификатор стиля кнопки по умолчанию.
///
/// `StandardButtonStyle` применяет согласованный стиль к кнопкам в приложении,
/// включая цвет, размер и визуальный стиль:
/// - стиль `.bordered`
/// - цвет `.brandPrimary`
/// - размер `.large`
///
/// Используется для унификации внешнего вида всех кнопок в интерфейсе.
///
/// - Пример использования:
/// ```swift
/// Button("Добавить") {
///     // действие
/// }
/// .standardButtonStyle()
/// ```
struct StandardButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.brandPrimary)
            .controlSize(.large)
    }
}
