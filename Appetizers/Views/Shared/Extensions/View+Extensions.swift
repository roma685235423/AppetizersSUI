import SwiftUI

extension View {
    
    /// Применяет стандартный стиль кнопки `StandardButtonStyle`.
      ///
      /// Упрощённый способ применения визуально согласованного стиля ко всем кнопкам:
      /// - стиль `.bordered`
      /// - цвет `.brandPrimary`
      /// - размер `.large`
      ///
      /// - Returns: Представление с применённым стилем.
      ///
      /// - Пример:
      /// ```swift
      /// Button("Сохранить") { ... }
      ///     .standardButtonStyle()
      /// ```
    public func standardButtonStyle() -> some View {
        modifier(StandardButtonStyle())
    }
}

